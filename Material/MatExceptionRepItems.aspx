<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRepItems.aspx.cs" Inherits="Material_MatExceptionRepItems"
    Title="ESD" %>

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
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - divFooterButton - 60 + "px";
            grid.get_element().style.width = width - 15 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
        function handleSpace(sender, eventArgs) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
            }
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
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label14" runat="server" Text="Select Item"></asp:Label>
                </td>
                <td style="height: 29px">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="150px" EmptyMessage="Search Item..."
                        AutoPostBack="true">
                    </telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlItemList" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlItemSource"
                        DataTextField="INSP_MAT_TITLE" DataValueField="INSP_MAT_TITLE" OnDataBinding="ddlItemList_DataBinding" Width="200px"
                        CausesValidation="false" OnSelectedIndexChanged="ddlItemList_SelectedIndexChanged">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label6" runat="server" Text="PO Item No"></asp:Label>
                </td>
                <td style="height: 29px">
                    <telerik:RadTextBox ID="txtPOitem" runat="server" Width="60px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="poItemValidator" runat="server" ControlToValidate="txtPOitem" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label15" runat="server" Text="MR Item No"></asp:Label>
                </td>
                <td style="height: 29px">
                    <telerik:RadTextBox ID="txtMRItem" runat="server" Width="60px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtMRItem" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatCode" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label16" runat="server" Text="Material Description"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatDescr" runat="server" Width="200px" Enabled="false" TextMode="MultiLine"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="108px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label17" runat="server" Text="Cable Drum No"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cabledrum" runat="server" AppendDataBoundItems="True" DataSourceID="cabledrumDataSource"
                        DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" Width="150px">
                        <asp:ListItem Selected="True">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="cabledrumValidator" runat="server" ControlToValidate="cabledrum" ValidationGroup="Submit"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label3" runat="server" Text="Exception Flag"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboFalg" runat="server" AppendDataBoundItems="True" DataSourceID="flagDataSource"
                        DataTextField="EXCP_DESCR" DataValueField="EXCP_FLG" Width="150px">
                        <asp:ListItem Selected="True">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="flagValidator" runat="server" ControlToValidate="cboFalg" ValidationGroup="Submit"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label4" runat="server" Text="Exception Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="63px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="excpQtyValidator" runat="server" ControlToValidate="txtQty" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
            DataKeyNames="EXCP_ITEM_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin" AllowSorting="true"
            OnDataBound="itemsGridView_DataBound" PageSize="50" onkeypress="handleSpace(event)" OnItemDataBound="itemsGridView_ItemDataBound"
            OnItemCommand="itemsGridView_ItemCommand" OnDataBinding="itemsGridView_DataBinding" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AllowAutomaticUpdates="true" DataKeyNames="EXCP_ITEM_ID" EditMode="InPlace" AllowMultiColumnSorting="true"
                AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="MIR_ITEM" ReadOnly="true" HeaderText="MRIR ITEM" SortExpression="MIR_ITEM"
                        AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM"  HeaderText="PO ITEM" SortExpression="PO_ITEM"
                        AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1"
                        AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" ReadOnly="True" SortExpression="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="SIZE" ReadOnly="True" SortExpression="SIZE_DESC" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="THK" ReadOnly="True" SortExpression="WALL_THK" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" HeaderText="UNIT" ReadOnly="True" SortExpression="UOM_NAME" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" ReadOnly="True" SortExpression="ITEM_NAM" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="HEAT NO" UniqueName="HEAT_NO" AutoPostBackOnFilter="true" SortExpression="HEAT_NO" AllowFiltering="false" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                 
                    <telerik:GridTemplateColumn DataField="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="cabledrum" runat="server" DataSourceID="cabledrumDataSource" Width="120px" DropDownWidth="200px" DropDownHeight="100px"
                                DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" SelectedValue='<%# Bind("CABLE_DRUM_NO") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Bind("CABLE_DRUM_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="EXCP_FLG" UniqueName="EXCP_FLG" HeaderText="EXCP FLG" SortExpression="EXCP_FLG" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="flagDataSource" Width="120px" DropDownWidth="200px" DropDownHeight="100px"
                                DataTextField="EXCP_DESCR" DataValueField="EXCP_FLG" SelectedValue='<%# Bind("EXCP_FLG") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Bind("EXCP_FLG") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="EXCP_QTY" HeaderText="EXCP QTY" AutoPostBackOnFilter="true" SortExpression="EXCP_QTY" AllowFiltering="false" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="CLEAR_QTY" HeaderText="CLEAR QTY" AutoPostBackOnFilter="true" SortExpression="CLEAR_QTY" AllowFiltering="false" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    
                    <telerik:GridTemplateColumn DataField="CLEAR_DATE" DataType="System.DateTime" FilterControlAltText="Filter CLEAR_DATE column"
                        HeaderText="CLEARED DATE" SortExpression="CLEAR_DATE" UniqueName="CLEAR_DATE" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtDateEdit" runat="server" DbSelectedDate='<%# Bind("CLEAR_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label13" runat="server" Text='<%# Eval("CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                      <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" AutoPostBackOnFilter="true" SortExpression="REMARKS" AllowFiltering="false" FilterControlWidth="50px">
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

    <asp:SqlDataSource ID="flagDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT EXCP_FLG, EXCP_DESCR FROM PIP_MAT_EXCEPTION_FLG ORDER BY EXCP_DESCR'></asp:SqlDataSource>
    <asp:SqlDataSource ID="cabledrumDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT DISTINCT Nvl(MID.CABLE_DRUM_NO,'NA') as CABLE_DRUM_NO
              FROM PRC_MAT_INSP_DETAIL MID 
                WHERE mid.mir_id=(SELECT mer.mat_rcv_id FROM  PIP_MAT_EXCEPTION_REP MER WHERE MER.EXCP_ID=:EXCP_ID)
         UNION 
             SELECT DISTINCT Nvl(CABLE_DRUM_NO,'NA') as CABLE_DRUM_NO
              FROM PIP_MAT_TRANSFER_RCV_DT  
             WHERE RCV_ID=
             (SELECT mer.mat_rcv_id FROM  PIP_MAT_EXCEPTION_REP MER WHERE MER.EXCP_ID=:EXCP_ID)">
          <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="EXCP_ID" QueryStringField="EXCP_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_EXCP_REP_ITEMTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_EXCP_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>


            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="EXCP_FLG" Type="String" />
            <asp:Parameter Name="EXCP_QTY" Type="Decimal" />
            <asp:Parameter Name="CLEAR_QTY" Type="Decimal" />
            <asp:Parameter Name="CLEAR_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="original_EXCP_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="EXCP_ID" QueryStringField="EXCP_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT  INSP_MAT_TITLE 
                        FROM VIEW_MRIR_ESD
                        WHERE MIR_ID IN 
                        (SELECT MAT_RCV_ID FROM PIP_MAT_EXCEPTION_REP WHERE EXCP_ID = :EXCP_ID)
                        AND (INSP_MAT_TITLE  LIKE FNC_FILTER(:FILTER) OR :FILTER LIKE 'XXX')
                        AND RCV_QTY &gt; ACPT_QTY
                          UNION 
                       SELECT PIP_MAT_TRANSFER_RCV_DT.MR_ITEM_NO || '-' || MAT_CODE1 AS INSP_MAT_TITLE
                         FROM PIP_MAT_TRANSFER_RCV_DT
                         INNER JOIN PIP_MAT_STOCK 
                         ON PIP_MAT_TRANSFER_RCV_DT.MAT_ID = PIP_MAT_STOCK.MAT_ID
                         WHERE RCV_ID IN 
                        (SELECT MAT_RCV_ID FROM PIP_MAT_EXCEPTION_REP WHERE EXCP_ID = :EXCP_ID)
                        AND (PIP_MAT_TRANSFER_RCV_DT.MR_ITEM_NO || '-' || MAT_CODE1  LIKE FNC_FILTER(:FILTER) OR :FILTER LIKE 'XXX')">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="EXCP_ID" QueryStringField="EXCP_ID" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
