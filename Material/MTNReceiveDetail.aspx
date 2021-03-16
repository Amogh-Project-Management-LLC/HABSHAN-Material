<%@ Page Title="MTN Receive" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MTNReceiveDetail.aspx.cs" Inherits="Material_MTNReceiveDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function RowDblClickCancel(sender, eventArgs) {
            return false;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
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

    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Items" Width="100px" OnClick="btnAdd_Click" Visible="false"></telerik:RadButton>
        <telerik:RadButton ID="btnAddFromMTN" runat="server" Text="Import from Transfer" Width="150px" OnClick="btnAddFromMTN_Click" Visible="false"></telerik:RadButton>
        <telerik:RadButton ID="btnImportBarcode" runat="server" Text="Import Barcode" Width="120px" OnClick="btnImportBarcode_Click" Visible="false"></telerik:RadButton>
        <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" Width="150px" ForeColor="Red" Visible="false"
            OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
        </telerik:RadButton>

    </div>
    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Material Code</td>
                <td>
                    <telerik:RadComboBox ID="cboMatCode" runat="server" Width="200px" AllowCustomText="True" DataSourceID="sqlMaterialSource" DataTextField="MAT_CODE1"
                        DataValueField="MAT_ID" Filter="Contains" AutoPostBack="true" OnSelectedIndexChanged="cboMatCode_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; padding-left: 5px; background-color: gainsboro">PO Number
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPO" DataSourceID="PODataSource" DataTextField="PO_NO" DataValueField="PO_ID" runat="server"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke;">Material Description</td>
                <td>
                    <telerik:RadTextBox ID="txtMatDescr" runat="server" Width="350px" TextMode="MultiLine" Enabled="false"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke;">Mr Item No</td>
                <td>

                    <telerik:RadDropDownList ID="ddlMR" runat="server" DataSourceID="SqlMrItemSource" DataTextField="MR_ITEM_NO" AppendDataBoundItems="True"
                        DataValueField="MR_ITEM_NO" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlMR_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke;">No Of Pieces</td>
                <td>
                    <telerik:RadTextBox ID="txtPieces" runat="server" Width="350px"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Heat No</td>
                <td>
                    <%--<telerik:RadAutoCompleteBox ID="txtAutoHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO" EmptyMessage="Start typing Heat No....." InputType="Text"></telerik:RadAutoCompleteBox>--%>

                    <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO" OnDataBinding="txtHeatNo_DataBinding"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke;">Cable Drum No</td>
                <td>
                    <telerik:RadDropDownList ID="ddlCableDrum" runat="server" DataSourceID="SqlCableDrum" DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" OnDataBinding="txtCableDrum_DataBinding"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Paint System</td>
                <td>

                    <telerik:RadDropDownList ID="ddlps" runat="server" DataSourceID="sqlPaintSystem" DataTextField="PAINT_SYS" DataValueField="PAINT_SYS" OnDataBinding="txtPS_DataBinding"></telerik:RadDropDownList>
                </td>

            </tr>

            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">Receive Qty</td>
                <td>
                    <telerik:RadTextBox ID="txtReceiveQty" runat="server" Width="160px" EmptyMessage="Receive Qty.."></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; padding-left: 5px; background-color: whitesmoke">ESD</td>
                <td>
                    <telerik:RadTextBox ID="txtExcess" runat="server" Width="80px" EmptyMessage="Excess.."></telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtShort" runat="server" Width="80px" EmptyMessage="Shortage.."></telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtDamage" runat="server" Width="80px" EmptyMessage="Damage.."></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None" OnPreRender="itemsGrid_PreRender"
            AllowAutomaticUpdates="true" AllowAutomaticDeletes="true" OnItemDataBound="itemsGrid_ItemDataBound" AllowMultiRowSelection="true"
            AllowFilteringByColumn="true" AllowSorting="true" PageSize="50" onkeypress="handleSpace(event)" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>

            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="RCV_ITEM_ID" EditMode="InPlace"
                AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmText="Are you sure to delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <%--<telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" AllowFiltering="true" AutoPostBackOnFilter="true"
                        HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO">
                        <ItemStyle Width="170px" />
                        <HeaderStyle Width="170px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridTemplateColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                        SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="false">
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
                    <%-- <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" AllowFiltering="true" AutoPostBackOnFilter="true"
                        HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>--%>
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
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM NO"
                        AutoPostBackOnFilter="true" SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO" FilterControlWidth="30px">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" ReadOnly="true" FilterControlAltText="Filter MAT_DESCR column" AllowFiltering="true" AutoPostBackOnFilter="true"
                        HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" AllowFiltering="false"
                        SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" ReadOnly="true" FilterControlAltText="Filter SIZE_DESC column" AllowFiltering="false"
                        HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" ReadOnly="true" FilterControlAltText="Filter WALL_THK column"
                        AllowFiltering="false" HeaderText="THK" SortExpression="WALL_THK" UniqueName="WALL_THK">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" ReadOnly="true" FilterControlAltText="Filter UOM_NAME column" AllowFiltering="false"
                        HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" FilterControlAltText="Filter RCV_QTY column" HeaderText="RECIEVE QTY" AllowFiltering="false"
                        SortExpression="RCV_QTY" UniqueName="RCV_QTY" DataType="System.Decimal" DataFormatString="{0:N2}">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" AllowFiltering="false"
                        SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column" HeaderText="CABLE DRUM NO" AllowFiltering="false"
                        SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT SYSTEM" AllowFiltering="false"
                        SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NO_OF_PIECE" FilterControlAltText="Filter NO_OF_PIECE column" HeaderText="NO OF PIECES" AllowFiltering="false"
                        SortExpression="NO_OF_PIECE" UniqueName="NO_OF_PIECE">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHORT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SHORT_QTY column" AllowFiltering="false"
                        HeaderText="SHORT QTY" DataFormatString="{0:N2}" SortExpression="SHORT_QTY" UniqueName="SHORT_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DAMAGE_QTY" DataType="System.Decimal" FilterControlAltText="Filter DAMAGE_QTY column" AllowFiltering="false"
                        HeaderText="DAMAGE QTY" SortExpression="DAMAGE_QTY" DataFormatString="{0:N2}" UniqueName="DAMAGE_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXCESS_QTY" DataType="System.Decimal" FilterControlAltText="Filter EXCESS_QTY column" AllowFiltering="false"
                        HeaderText="EXCESS QTY" DataFormatString="{0:N2}" SortExpression="EXCESS_QTY" UniqueName="EXCESS_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="200px" HorizontalAlign="Right" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="RCV_ITEM_ID" HeaderText="TRANSF ITEM ID" SortExpression="RCV_ITEM_ID" ReadOnly="true"
                        AllowFiltering="false">
                        <ItemStyle Width="1px" />
                        <HeaderStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
        </telerik:RadGrid>
    </div>
    <div style="margin-top: 3px" id="divFooterHeight">
        <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80px" OnClick="btnDelete_Click" Visible="false"></telerik:RadButton>
        <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="false"></telerik:RadButton>
        <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="false" OnClick="btnNo_Click"></telerik:RadButton>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCV_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>

            <asp:Parameter Name="RCV_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PAINT_SYS" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SHORT_QTY" Type="Decimal" />
            <asp:Parameter Name="DAMAGE_QTY" Type="Decimal" />
            <asp:Parameter Name="EXCESS_QTY" Type="Decimal" />
            <asp:Parameter Name="NO_OF_PIECE" Type="Decimal" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="MR_ITEM_NO" Type="Decimal" />
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1
                                FROM VIEW_MAT_TRANSFER_RCV_BAL
                                WHERE TRANSF_ID = (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = :RCV_ID)
                                AND BAL_QTY &gt; 0">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT HEAT_NO FROM PIP_MAT_TRANSF_DETAIL WHERE TRANSF_ID= (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID =:RCV_ID ) AND MR_ITEM_NO =:MR_ITEM_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
            <asp:ControlParameter ControlID="ddlMR" Name="MR_ITEM_NO" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlCableDrum" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT CABLE_DRUM_NO FROM PIP_MAT_TRANSF_DETAIL WHERE TRANSF_ID= (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID =:RCV_ID )  AND MR_ITEM_NO =:MR_ITEM_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
            <asp:ControlParameter ControlID="ddlMR" Name="MR_ITEM_NO" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlPaintSystem" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_SYS FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID =:MAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenMatID" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenMatID" runat="server" />
    <asp:SqlDataSource ID="PODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PIP_PO.PO_ID, PIP_PO.PO_NO FROM PIP_MAT_TRANSF_DETAIL LEFT OUTER JOIN PIP_PO 
                                ON PIP_MAT_TRANSF_DETAIL.po_id=pip_po.po_id
                                WHERE MAT_ID=:MAT_ID AND TRANSF_ID IN (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID=:RCV_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
            <asp:ControlParameter ControlID="cboMatCode" Name="MAT_ID" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlMrItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT MR_ITEM_NO  FROM PIP_MAT_TRANSF_DETAIL WHERE MAT_ID =:MAT_ID AND TRANSF_ID 
                       IN (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = :RCV_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
</asp:Content>

