<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialQuarantineDetail.aspx.cs" Inherits="Material_MaterialQuarantineDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
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
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Items" Width="100px" OnClick="btnAdd_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
          <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Mat Code:</td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server" AutoPostBack="True" EmptyMessage="Search Material here..."></asp:TextBox>
                    <asp:DropDownList ID="ddlMatItem" runat="server" AppendDataBoundItems="True"
                        OnDataBinding="ddlMatItem_OnDataBinding" DataSourceID="matSource" OnSelectedIndexChanged="ddlMatItem_SelectedIndexChanged" CausesValidation="false" AutoPostBack="true"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Material Description:
                </td>
                <td>
                    <asp:TextBox ID="txtMatDescr" runat="server" Width="300px" TextMode="MultiLine" Enabled="false"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Po Number
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPO" runat="server" AutoPostBack="true" Width="200px"
                        DataSourceID="MatPODataSource" DataTextField="PO_NO" DataValueField="PO_ID">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Heat No:
                </td>
                <td>
                    <asp:TextBox ID="txtHeatno" runat="server"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Cable Drum No:
                </td>
                <td>
                    <asp:TextBox ID="txtDrumno" runat="server"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Quarantine Item:
                </td>
                <td>
                    <asp:TextBox ID="txtQritem" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Save"
                        ControlToValidate="txtQritem" ErrorMessage="**" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Quantity:
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Save"
                        ControlToValidate="txtQty" ErrorMessage="**" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Category:</td>
                <td>
                    <asp:DropDownList ID="ddlQuaranCat" runat="server" AppendDataBoundItems="True"
                        DataSourceID="QuanrantineCatSource" DataTextField="QUARAN_CAT_DESC"
                        DataValueField="QUARAN_CAT" Width="200px">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px;">Remarks:
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" ValidationGroup="Save"></telerik:RadButton>
                    <telerik:RadButton ID="btnHide" runat="server" Text="Hide" Width="80px" OnClick="btnHide_Click" CausesValidation="false"></telerik:RadButton>

                </td>
            </tr>
        </table>
                         </ContentTemplate>
                </asp:UpdatePanel>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True" CellSpacing="0" GridLines="None" AutoGenerateColumns="False" DataSourceID="itemSource"
            PageSize="20" OnItemCommand="RadGrid1_ItemCommand" OnDataBinding="RadGrid1_DataBinding" OnItemDataBound="RadGrid1_ItemDataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView DataKeyNames="QRNTINE_UNIQ_ID" DataSourceID="itemSource" EditMode="InPlace"
                EditFormSettings-EditColumn-ButtonType="ImageButton" ClientDataKeyNames="QRNTINE_UNIQ_ID" AllowMultiColumnSorting="true" PagerStyle-AlwaysVisible="true"
                TableLayout="Fixed">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn DataField="QUARAN_CAT_DESC" FilterControlAltText="Filter QUARAN_CAT_DESC column" FilterControlWidth="50px"
                        HeaderText="CATEGORY" SortExpression="QUARAN_CAT_DESC" UniqueName="QUARAN_CAT_DESC"
                        CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList11" runat="server" SelectedValue='<%# Bind("QUARAN_CAT") %>'
                                DataSourceID="QuanrantineCatSource" DataTextField="QUARAN_CAT_DESC"
                                DataValueField="QUARAN_CAT">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("QUARAN_CAT_DESC") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
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
                    <telerik:GridBoundColumn DataField="QR_ITEM" FilterControlAltText="Filter QR_ITEM column"
                        HeaderText="QR ITEM" SortExpression="QR_ITEM" UniqueName="QR_ITEM"
                        AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column"
                        HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" ReadOnly="true"
                        AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column"
                        HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" ReadOnly="true"
                        AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column"
                        HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME" ReadOnly="true" FilterControlWidth="20px"
                        AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column"
                        HeaderText="SIZE DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" ReadOnly="true"
                        AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column"
                        HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" 
                        AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column"
                        HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO" 
                        AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" FilterControlAltText="Filter QTY column"
                        HeaderText="QTY" SortExpression="QTY" UniqueName="QTY" AllowFiltering="true" DataFormatString="{0:N2}" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" HorizontalAlign="Right" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="QuanrantineCatSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT QUARAN_CAT, QUARAN_CAT_DESC FROM PIP_QUARANTINE_CAT"></asp:SqlDataSource>


    <asp:SqlDataSource ID="subconSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR "></asp:SqlDataSource>


    <asp:SqlDataSource ID="matSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE (MAT_CODE1 LIKE '%' || :MAT_CODE1 || '%')">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtMatCode" DefaultValue="XXX"
                Name="MAT_CODE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:ObjectDataSource ID="itemSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="dsMaterialDTableAdapters.VIEW_QUARANTINE_DETAILTableAdapter"
        UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_QRNTINE_UNIQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="QUARAN_CAT" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="QR_ITEM" Type="String" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="original_QRNTINE_UNIQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="QRNTINE_ID"
                QueryStringField="id" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="MatPODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT PO_NO,PO_ID FROM VIEW_MRIR_MAT_SOURCE
                       WHERE MAT_ID=:MAT_ID ">
        <SelectParameters>

            <asp:ControlParameter ControlID="ddlMatItem" Name="MAT_ID" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>
</asp:Content>

