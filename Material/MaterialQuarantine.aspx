<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialQuarantine.aspx.cs" Inherits="Material_MaterialQuarantine" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("QRNTINE_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=32&REF_ID=" + id, "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
                alert(txt);
            }
        }
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight

            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width - 12 + "px";
            grid.repaint();
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnRegister" runat="server" Text="New MQ" Width="100px"></telerik:RadButton>
        <telerik:RadButton ID="btnMaterial" runat="server" Text="Items" Width="80px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100px" OnClick="btnPreview_Click"></telerik:RadButton>
        <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
            <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
        </asp:LinkButton>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" OnItemDataBound="RadGrid1_ItemDataBound" DataKeyNames="QRNTINE_ID"
                    CellSpacing="0" GridLines="None" AutoGenerateColumns="False" DataSourceID="itemstDataSource"
                    PageSize="50" OnItemCommand="RadGrid1_ItemCommand" OnDataBinding="RadGrid1_DataBinding" onkeypress="handleSpace(event)">
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
                    <MasterTableView DataKeyNames="QRNTINE_ID" DataSourceID="itemstDataSource" EditMode="InPlace" ClientDataKeyNames="QRNTINE_ID"
                        EditFormSettings-EditColumn-CancelImageUrl="../App_Themes/BlueTheme/images/cross.png"
                        EditFormSettings-EditColumn-InsertImageUrl="../App_Themes/BlueTheme/images/tick.png"
                        EditFormSettings-EditColumn-ButtonType="ImageButton" AllowMultiColumnSorting="true" PagerStyle-AlwaysVisible="true"
                        TableLayout="Fixed">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn
                                ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="PDF" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="40px" />
                                <HeaderStyle Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="QRNTINE_NO" FilterControlAltText="Filter QRNTINE_NO column" HeaderText="QUARANTINE NO" SortExpression="QRNTINE_NO" UniqueName="QRNTINE_NO"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" /> 
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUBCON NAME"
                                SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME" AllowFiltering="true" AutoPostBackOnFilter="true">
                                <ItemStyle Width="250px" />
                                <HeaderStyle Width="250px" />
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="rcbSC" runat="server" DataSourceID="SqlDataSource1" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                        ItemsPerRequest="10" ShowMoreResultsBox="true"
                                        DataTextField="SUB_CON_NAME" DataValueField="SC_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                        AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:RadComboBoxItem Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="SUB_CONLabel" runat="server" Text='<%# Eval("SUB_CON_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME"
                                SortExpression="STORE_NAME" UniqueName="STORE_NAME" AllowFiltering="true" AutoPostBackOnFilter="true">
                                <ItemStyle Width="250px" />
                                <HeaderStyle Width="250px" />
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="rcbST" runat="server" DataSourceID="SqlDataSource2" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                        ItemsPerRequest="10" ShowMoreResultsBox="true"
                                        DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                        AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:RadComboBoxItem Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="STORELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column"
                                HeaderText="QUARANTINE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" AllowFiltering="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("CREATE_DATE") %>' Width="120px"></telerik:RadDatePicker>

                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" />
                            </telerik:GridTemplateColumn>
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
                            <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlWidth="40px" ReadOnly="true" AllowFiltering="false" >
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                                SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="itemstDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM  VIEW_QUARANTINE ORDER BY QRNTINE_NO"
        UpdateCommand="UPDATE PIP_QUARANTINE
                        SET       REMARKS = :REMARKS, QRNTINE_NO = :QRNTINE_NO, CREATE_DATE = :CREATE_DATE, CREATE_BY = :CREATE_BY, SC_ID = :SC_ID, STORE_ID = :STORE_ID
                        WHERE (QRNTINE_ID = :QRNTINE_ID)"
        DeleteCommand="DELETE FROM PIP_QUARANTINE WHERE (QRNTINE_ID = :QRNTINE_ID)">
        
         <DeleteParameters>
            <asp:Parameter Name="QRNTINE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            
            <asp:Parameter Name="QRNTINE_NO" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="QRNTINE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID AS SC_ID,SUB_CON_NAME FROM SUB_CONTRACTOR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT STORE_ID,STORE_NAME FROM STORES_DEF"></asp:SqlDataSource>
    <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME AS CREATE_BY FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>
</asp:Content>

