<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_MatItems.aspx.cs" Inherits="Erection_Additional_MatItems"
    Title="Additional Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
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
        function RadConfirm(sender, args) {
            var callBackFunction = function (shouldSubmit) {
                if (shouldSubmit) {
                    sender.click();
                    if (Telerik.Web.Browser.ff) {
                        sender.get_element().click();
                    }
                }
            };

            var text = "Are you sure you want to Delete?";
            radconfirm(text, callBackFunction, 300, 200, null, "RadConfirm");
            args.set_cancel(true);
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Add Items" Width="100" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false" ValidationGroup="Submit"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImportBarcode" runat="server" Text="Import Barcode" Width="120" OnClick="btnImportBarcode_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" ForeColor="Red" Visible="false" Width="200"
                        OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
                    </telerik:RadButton>
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
        <table id="EntryTable" runat="server" visible="false">

            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
               <%-- <td>
                    <telerik:RadAutoCompleteBox ID="txtMatCode" runat="server" EmptyMessage="Start typing Material Code.. " Width="250px"
                        DataSourceID="itemCodeSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" InputType="Text" AutoPostBack="true"
                        OnTextChanged="txtMatCode_TextChanged">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>--%>
                 <td>
                    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
                        Filter="Contains" DataValueField="MAT_ID" Width="250px" AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Matcode"
                        ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged">
                    </telerik:RadComboBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="ddlMatCode" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">PO Number
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPo" DataSourceID="PoDataSource" DataTextField="PO_NO" DataValueField="PO_ID" runat="server"></telerik:RadDropDownList>
                    
                </td>
            </tr>

            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Item Description"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatDescr" runat="server" Width="400px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: whitesmoke;">
                    <asp:Label ID="Label8" runat="server" Text="Available Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtAvlQty" runat="server" Width="400px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>

            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="114px" AutoPostBack="True"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="HeatNoValidator" runat="server" ControlToValidate="txtHeatNo" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>

                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaintCode" runat="server" Width="114px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="Cable Drum No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCableDrumNo" runat="server" Width="110px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="DrumValidator" runat="server" ControlToValidate="txtCableDrumNo" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Issued Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="80px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" OnItemDataBound="itemsGridView_ItemDataBound" ShowStatusBar="true"
            DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO,CABLE_DRUM_NO" DataSourceID="itemsDataSource" SkinID="GridViewSkin" AllowSorting="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowMultiRowSelection="true"
            OnDataBound="itemsGridView_DataBound" PageSize="50" onkeypress="handleSpace(event)" OnItemCommand="itemsGridView_ItemCommand" OnDataBinding="itemsGridView_DataBinding">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO,CABLE_DRUM_NO" EditMode="InPlace" AllowMultiColumnSorting="true"
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridTemplateColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="rcbMAT" runat="server" DataSourceID="MATERIALDataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                ItemsPerRequest="10" ShowMoreResultsBox="true"
                                DataTextField="MAT_CODE1" DataValueField="MAT_ID" SelectedValue='<%# Bind("MAT_ID") %>'
                                AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="MAT_CODE1Label" runat="server" Text='<%# Eval("MAT_CODE1") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                  <telerik:GridTemplateColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                    SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="true" AutoPostBackOnFilter="true">
                    <ItemStyle Width="250px" />
                    <HeaderStyle Width="250px" />
                    <EditItemTemplate>
                        <telerik:RadComboBox ID="rcbPO" runat="server" DataSourceID="SqlDataSource1" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                            ItemsPerRequest="10" ShowMoreResultsBox="true"
                            DataTextField="PO_NO" DataValueField="PO_ID" SelectedValue='<%# Bind("PO_ID") %>'
                            AppendDataBoundItems="True">
                            <Items>
                                <telerik:RadComboBoxItem Selected="true" />
                            </Items>
                        </telerik:RadComboBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PO_NOLabel" runat="server" Text='<%# Eval("PO_NO") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                   
                    <telerik:GridBoundColumn DataField="MAT_DESCR" UniqueName="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="80px"
                        ReadOnly="true">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" UniqueName="ITEM_NAM" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" AutoPostBackOnFilter="true" FilterControlWidth="70px"
                        ReadOnly="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" UniqueName="SIZE_DESC" HeaderText="SIZE" SortExpression="SIZE_DESC" AllowFiltering="false"
                        ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" UniqueName="WALL_THK" HeaderText="THK" SortExpression="WALL_THK" AllowFiltering="false"
                        ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" UniqueName="UOM_NAME" HeaderText="UNIT" SortExpression="UOM_NAME" AllowFiltering="false"
                        ReadOnly="true">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" UniqueName="HEAT_NO" HeaderText="HEAT NO" SortExpression="HEAT_NO" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PAINT_CODE" UniqueName="PAINT_CODE" HeaderText="PAINT CODE" SortExpression="PAINT_CODE" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISSUE_QTY" UniqueName="ISSUE_QTY" HeaderText="ISSUED QTY" SortExpression="ISSUE_QTY" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" UniqueName="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="ADD_ISSUE_ID" HeaderText="ADD ISSUE ID" SortExpression="ADD_ISSUE_ID" ReadOnly="true"
                    AllowFiltering="false">
                    <ItemStyle Width="1px" />
                    <HeaderStyle Width="1px" />
                </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_ID" HeaderText="MAT ID" SortExpression="MAT_ID" ReadOnly="true"
                    AllowFiltering="false">
                    <ItemStyle Width="1px" />
                    <HeaderStyle Width="1px" />
                </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ID" HeaderText="PO ID" SortExpression="PO_ID" ReadOnly="true"
                    AllowFiltering="false">
                    <ItemStyle Width="1px" />
                    <HeaderStyle Width="1px" />
                </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.VIEW_ADAPTER_ISSUE_ADD_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
            <asp:Parameter Name="original_CABLE_DRUM_NO" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
            <asp:Parameter Name="original_CABLE_DRUM_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUED_ID" QueryStringField="ADD_ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="mrirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_RCV_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1
FROM PIP_MAT_STOCK WHERE  EXISTS (SELECT MAT_ID FROM 
                                        (SELECT MAT_ID FROM PIP_MAT_TRANSFER_RCV_DT
                                          UNION 
                                          SELECT MAT_ID FROM PRC_MAT_INSP,PRC_MAT_INSP_DETAIL
                                          WHERE PRC_MAT_INSP.MIR_ID = PRC_MAT_INSP_DETAIL.MIR_ID
                                          AND  STORE_ID=3 )
                                  WHERE MAT_ID =PIP_MAT_STOCK.MAT_ID)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMaterialRequest" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_REQ_ID, MAT_REQ_NO
    FROM VIEW_MAT_REQ_ISSUE_BAL
    WHERE BAL_QTY &gt; 0 
    AND REQ_TO_STORE_ID IN (SELECT STORE_ID FROM PIP_MAT_ISSUE_ADD WHERE ADD_ISSUE_ID = :ADD_ISSUE_ID)
    AND MAT_ID =:MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUE_ID" QueryStringField="ADD_ISSUE_ID" />
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="PoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO MAIN  WHERE EXISTS 
                       (SELECT PO_ID FROM PIP_PO_DETAIL WHERE PO_ID = MAIN.PO_ID AND MAT_ID=:MAT_ID   )">
         <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="MAT_ID" ControlID="ddlMatCode" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters> 

     </asp:SqlDataSource>
     <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>
</asp:Content>
