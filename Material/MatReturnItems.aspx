<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReturnItems.aspx.cs" Inherits="Material_MatReturn" Title="Material Return" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
          <script type="text/javascript">
         
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
                grid.get_element().style.height = (height) - divHeight - divButton - divFooter -  70 + "px";
                grid.get_element().style.width = width -20 + "px";
                grid.repaint();
            }
                //]]>
        </script>

    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="100px" OnClick="btnEntry_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false" ValidationGroup="Submit"></telerik:RadButton>
        <telerik:RadButton ID="btnImportExcel" runat="server" Text="Bulk Import" Width="110px" OnClick="btnImportExcel_Click">
            <Icon PrimaryIconUrl="../Images/icons/excel.png" />
        </telerik:RadButton>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 150px; background-color: WhiteSmoke;">Reusable</td>
                <td>
                    <telerik:RadDropDownList ID="ddlReusable" runat="server" OnSelectedIndexChanged="ddlReusable_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Text="-(Select)-" Value="-1" Selected="true" />
                            <telerik:DropDownListItem Text="Y" Value="Y" />
                            <telerik:DropDownListItem Text="N" Value="N" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Material Code
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
                        Filter="Contains" DataValueField="MAT_ID" Width="250px" AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Matcode"
                        ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
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
                <td style="width: 130px; background-color: WhiteSmoke;">Heat No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="HeatNoValidator" runat="server" ControlToValidate="txtHeatNo" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Cable Drum No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDrumNo" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDrumNo" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaintCode" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Return Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="150px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="returnGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnItemDataBound ="returnGridView_ItemDataBound"
            DataSourceID="returnDataSource" SkinID="GridViewSkin" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn ="true"
            PageSize="50"  PagerStyle-AlwaysVisible="true"  DataKeyNames="RET_ITEM_ID" OnRowEditing="returnGridView_RowEditing">
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
            <MasterTableView AutoGenerateColumns="False" DataSourceID="returnDataSource" DataKeyNames="RET_ITEM_ID" AllowMultiColumnSorting="true"
                ClientDataKeyNames="RET_ITEM_ID" TableLayout="Fixed" EditMode="InPlace" AllowFilteringByColumn ="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>

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
                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="Material Description" ReadOnly="True" AllowFiltering="true" AutoPostBackOnFilter="true"
                        SortExpression="MAT_DESCR">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="THK" ReadOnly="True" AllowFiltering="false"
                        SortExpression="WALL_THK">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" ReadOnly="True" AllowFiltering="false"
                        SortExpression="ITEM_NAM">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" HeaderText="UNIT" ReadOnly="True" AllowFiltering="false"
                        SortExpression="UOM_NAME">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" HeaderText="Cable Drum Number" SortExpression="CABLE_DRUM_NO" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                  

                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="RET_QTY" HeaderText="Return Qty" SortExpression="RET_QTY" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                   
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="returnDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.PIP_MAT_RETURN_LISTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RET_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="RET_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="original_RET_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RET_ID" QueryStringField="MAT_RET_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO MAIN  WHERE EXISTS 
                       (SELECT PO_ID FROM PIP_PO_DETAIL WHERE PO_ID = MAIN.PO_ID AND MAT_ID =:MAT_ID )">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="MAT_ID" ControlID="ddlMatCode" PropertyName="SelectedValue" Type="Decimal" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>

</asp:Content>
