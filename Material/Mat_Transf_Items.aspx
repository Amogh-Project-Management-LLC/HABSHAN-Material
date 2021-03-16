<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf_Items.aspx.cs" Inherits="Erection_Additional_MatItems" Title="Material Transfer" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function RowDblClickCancel(sender, eventArgs) {
            return false;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px"
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>

    <div id="HeaderButtons">
        <table style="background-color: gainsboro;">
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
                    <telerik:RadButton ID="btnAddFromMTN" runat="server" Text="Import From MR" Width="200px" OnClick="btnAddFromMTN_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBarcodeImport" runat="server" Text="Import Barcode" OnClick="btnBarcodeImport_Click" Width="120px"></telerik:RadButton>
                </td>
                <td style="text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" ForeColor="Red" Visible="false"
                        OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <%--  <tr>
                <td style="width: 120px; background-color: whitesmoke;">Material Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatCode" runat="server" AutoPostBack="True" OnTextChanged="txtMatCode_TextChanged" CausesValidation="false"
                        Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>--%>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Material Code
                </td>
                <td>
                    <%-- <telerik:RadDropDownList ID="ddlMatCode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged" CausesValidation="false"
                       DataSourceID="MatDataSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" AppendDataBoundItems="true" >
                        <Items>
                            <telerik:DropDownListItem Text="Select Matcode" Value="-1"  Selected="true" />
                        </Items>
                    </telerik:RadDropDownList>--%>
                    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
                        Filter="Contains" DataValueField="MAT_ID" Width="250px" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Po Number
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlPO" runat="server" AutoPostBack="true"
                        DataSourceID="PODataSource" DataTextField="PO_NO" DataValueField="PO_ID">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Item Description</td>
                <td>
                    <telerik:RadTextBox ID="txtItemDescr" runat="server" Width="350px" TextMode="MultiLine" Enabled="false"></telerik:RadTextBox></td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Mr Item No
                </td>
                <td>

                    <telerik:RadDropDownList ID="ddlMR" runat="server" DataSourceID="SqlMrItemSource" DataTextField="MR_ITEM_NO" AppendDataBoundItems="True"
                        DataValueField="MR_ITEM_NO" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlMR_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>

                    <%--<telerik:RadTextBox ID="txtHeatNo" runat="server" Width="120px"></telerik:RadTextBox>--%>
                    <%-- <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Heat No
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO"
                        DataValueField="HEAT_NO" OnDataBinding="txtHeatNo_DataBinding">
                    </telerik:RadDropDownList>

                    <%--<telerik:RadTextBox ID="txtHeatNo" runat="server" Width="120px"></telerik:RadTextBox>--%>
                    <%-- <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Cable Drum No 
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlCabledrum" DataSourceID="CableDataSource"
                        DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" runat="server">
                    </telerik:RadDropDownList>
                    <%--<telerik:RadTextBox ID="txtCableDrum" runat="server" Width="120px"></telerik:RadTextBox>--%>
                    <%-- <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Box No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBoxNo" runat="server" Width="120px" Text="NA"></telerik:RadTextBox>
                    <%--  <asp:RequiredFieldValidator ID="BoxNoValidator" runat="server" ControlToValidate="txtBoxNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">No Of Pieces
                </td>
                <td>
                    <telerik:RadTextBox ID="txtNO_OF_PIECE" runat="server" Width="120px" Text="0"></telerik:RadTextBox>

                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPaintCode" runat="server" Width="120px" Text="NA"></telerik:RadTextBox>
                    <%--   <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Balance Stock Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtbalQty" runat="server" Width="350px" Enabled="false" ></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="WHC PO Balance Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtWHCPOBal" runat="server" Width="350px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>

                <td style="width: 120px; background-color: whitesmoke;">Transfer Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="120px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty" ValidationGroup="Submit"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    <telerik:RadLabel ID="lblbalqty" runat="server"></telerik:RadLabel>
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

    <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="true"
        DataSourceID="itemsDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
        OnItemDataBound="itemsGridView_ItemDataBound" OnDataBound="itemsGridView_DataBound" onkeypress="handleSpace(event)" OnPreRender="itemsGridView_PreRender"
        PageSize="50" AllowFilteringByColumn="true" OnItemCommand="itemsGridView_ItemCommand" OnDataBinding="itemsGridView_DataBinding" AllowMultiRowSelection="true"
        OnItemDeleted="itemsGridView_ItemDeleted" ShowStatusBar="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
        <ClientSettings>
            <Selecting AllowRowSelect="true" />
            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
        </ClientSettings>
        <ClientSettings AllowKeyboardNavigation="true">
            <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>

        </ClientSettings>

        <MasterTableView Name="ParentGrid" DataSourceID="itemsDataSource" DataKeyNames="TRANSF_ID,MR_ITEM_NO,TRANSF_ITEM_ID" EditMode="InPlace" AllowMultiColumnSorting="true"
            PagerStyle-AlwaysVisible="true" TableLayout="Fixed">

            <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                    <ItemStyle Width="55px" />
                    <HeaderStyle Width="55px" />
                </telerik:GridEditCommandColumn>

                <telerik:GridButtonColumn ConfirmDialogType="RadWindow"
                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                    UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="35px" />
                    <HeaderStyle Width="35px" />
                </telerik:GridButtonColumn>
                <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                    <HeaderStyle Width="35px" />
                    <ItemStyle Width="35px" />
                </telerik:GridClientSelectColumn>

                <%--<telerik:GridBoundColumn DataField="PO_NO" UniqueName="PO_NO" HeaderText="PO NUMBER" SortExpression="PO_NO" ReadOnly="True" FilterControlWidth="80px">
                    <ItemStyle Width="180px" />
                    <HeaderStyle Width="180px" />
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
                <telerik:GridBoundColumn DataField="MR_ITEM_NO" UniqueName="MR_ITEM_NO" HeaderText="MR ITEM NUM" SortExpression="MR_ITEM_NO"
                    FilterControlWidth="60px" AutoPostBackOnFilter="true" FilterControlAltText="MR_ITEM_NO">
                    <ItemStyle Width="120px" />
                    <HeaderStyle Width="120px" />
                </telerik:GridBoundColumn>
                <%-- <telerik:GridBoundColumn DataField="MAT_CODE1" UniqueName="MAT_CODE1" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" ReadOnly="True" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                    <ItemStyle Width="170px" />
                    <HeaderStyle Width="170px" />
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
                <telerik:GridBoundColumn DataField="MAT_DESCR" UniqueName="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" ReadOnly="True" SortExpression="MAT_DESCR" AutoPostBackOnFilter="true">
                    <ItemStyle Width="300px" />
                    <HeaderStyle Width="300px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME"
                    SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AllowFiltering="false" ReadOnly="true">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE"
                    SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="false" ReadOnly="true">
                    <ItemStyle Width="120px" />
                    <HeaderStyle Width="120px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                    SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="false" ReadOnly="true">
                    <ItemStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT"
                    SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false" ReadOnly="true">
                    <ItemStyle Width="60px" />
                    <HeaderStyle Width="60px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="BOX_NO" UniqueName="BOX_NO" HeaderText="BOX NO" SortExpression="BOX_NO"
                    FilterControlAltText="Filter BOX_NO column" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                    <ItemStyle Width="130px" />
                    <HeaderStyle Width="130px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PAINT_CODE" UniqueName="PAINT_CODE" HeaderText="PAINT CODE" SortExpression="PAINT_CODE"
                    FilterControlAltText="Filter PAINT_CODE column" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <%-- <telerik:GridTemplateColumn DataField="HEAT_NO" UniqueName="HEAT_NO" HeaderText="HEAT NO" AllowFiltering="false">
                        <ItemTemplate>
                           <asp:Label ID="HeatNoLabel" runat="server" Text='<%# Eval("HEAT_NO") %>'></asp:Label>
                        </ItemTemplate>
                    <EditItemTemplate>
                         <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataTextField="Heat_no" DataValueField="Heat_no"
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                    </EditItemTemplate>
                  <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" AllowFiltering="false">
                          <ItemTemplate>
                           <asp:Label ID="DrumNoLabel" runat="server" Text='<%# Eval("CABLE_DRUM_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <telerik:RadDropDownList  ID="ddlCableNo" runat="server" DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO"
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>--%>

                <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="HEAT NO"
                    SortExpression="HEAT_NO" UniqueName="HEAT_NO" AllowFiltering="false">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO"
                    SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" AllowFiltering="false">
                    <ItemStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TRANSF_QTY" FilterControlAltText="Filter TRANSF_QTY column" HeaderText="QUANTITY"
                    SortExpression="TRANSF_QTY" UniqueName="TRANSF_QTY" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NO_OF_PIECE" FilterControlAltText="Filter NO_OF_PIECE column" HeaderText="NO OF PIECE"
                    SortExpression="NO_OF_PIECE" UniqueName="NO_OF_PIECE" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="PIPE_LENGTH" FilterControlAltText="Filter PIPE_LENGTH column" HeaderText="PIPE LENGTH"
                    SortExpression="PIPE_LENGTH" UniqueName="PIPE_LENGTH" AllowFiltering="false">
                    <ItemStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                </telerik:GridBoundColumn>

                <telerik:GridTemplateColumn DataField="RECEIVE_DATE" DataType="System.DateTime" FilterControlAltText="Filter RECEIVE_DATE column"
                    HeaderText="RECEIVE DATE" SortExpression="RECEIVE_DATE" UniqueName="RECEIVE_DATE" AllowFiltering="false">
                    <EditItemTemplate>
                        <telerik:RadDatePicker ID="TextBox6" runat="server" DbSelectedDate='<%# Bind("RECEIVE_DATE") %>'
                            DateInput-DateFormat="dd-MMM-yyyy">
                        </telerik:RadDatePicker>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("RECEIVE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="180px" />
                    <HeaderStyle Width="180px" />
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                    <ItemStyle Width="180px" />
                    <HeaderStyle Width="180px" />
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TRANSF_ITEM_ID" HeaderText="TRANSF ITEM ID" SortExpression="TRANSF_ITEM_ID" ReadOnly="true"
                    AllowFiltering="false">
                    <ItemStyle Width="1px" />
                    <HeaderStyle Width="1px" />
                </telerik:GridBoundColumn>

            </Columns>


            <DetailTables>

                <telerik:GridTableView Name="ChildGrid" DataSourceID="ChildDataSource" DataKeyNames="RCV_ITEM_ID" EditMode="InPlace" AllowFilteringByColumn="false" Width="60%">
                    <ItemStyle BackColor="#ccffcc" />
                    <AlternatingItemStyle BackColor="#ccffcc" />
                    <ParentTableRelation>
                        <telerik:GridRelationFields DetailKeyField="TRANSF_ID" MasterKeyField="TRANSF_ID" />
                        <telerik:GridRelationFields DetailKeyField="MR_ITEM_NO" MasterKeyField="MR_ITEM_NO"></telerik:GridRelationFields>
                    </ParentTableRelation>
                    <Columns>
                        <telerik:GridBoundColumn DataField="RCV_NUMBER" ReadOnly="true" FilterControlAltText="Filter RCV_NUMBER column"
                            HeaderText="RCV NUMBER" SortExpression="RCV_NUMBER" UniqueName="RCV_NUMBER">
                            <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column"
                            HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                            <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="MR_ITEM_NO" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM NO"
                            AutoPostBackOnFilter="true" SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO" ReadOnly="true">
                            <ItemStyle Width="70px" />
                            <HeaderStyle Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="RCV_QTY" FilterControlAltText="Filter RCV_QTY column" HeaderText="RECIEVE QTY"
                            SortExpression="RCV_QTY" UniqueName="RCV_QTY" DataType="System.Decimal" DataFormatString="{0:N2}">
                            <ItemStyle Width="80px" HorizontalAlign="Right" />
                            <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO"
                            SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                            <ItemStyle Width="120px" />
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column" HeaderText="CABLE DRUM NO"
                            SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO">
                            <ItemStyle Width="120px" />
                            <HeaderStyle Width="120px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT SYSTEM"
                            SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                            <ItemStyle Width="90px" />
                            <HeaderStyle Width="90px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle Width="55px" />
                            <HeaderStyle Width="55px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridButtonColumn
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" ConfirmText="Are you sure to delete MTN Receive"
                            UniqueName="DeleteColumn">
                            <ItemStyle Width="35px" />
                            <HeaderStyle Width="35px" />
                        </telerik:GridButtonColumn>

                    </Columns>
                </telerik:GridTableView>
            </DetailTables>
        </MasterTableView>
        <HeaderStyle HorizontalAlign="Center" />
        <GroupingSettings CaseSensitive="false" />
    </telerik:RadGrid>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MAT_TRANSF_DTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TRANSF_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MR_ITEM_NO" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BOX_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="TRANSF_QTY" Type="Decimal" />
            <asp:Parameter Name="NO_OF_PIECE" Type="Decimal" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="RECEIVE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="MR_ITEM_NO" Type="Decimal" />
            <asp:Parameter Name="Original_TRANSF_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MR_ITEM_NO" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE MAT_ID IN 
        (SELECT MAT_ID FROM MATERIAL_REQUEST_DETAIL WHERE MAT_REQ_ID IN 
        (SELECT MAT_REQ_ID FROM PIP_MAT_TRANSF WHERE TRANSF_ID=:TRANSF_ID))">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT PIP_PO.PO_ID, PIP_PO.PO_NO FROM MATERIAL_REQUEST_DETAIL LEFT OUTER JOIN PIP_PO 
            ON MATERIAL_REQUEST_DETAIL.po_id=pip_po.po_id
            WHERE MAT_ID=:MAT_ID AND MAT_REQ_ID IN (SELECT MAT_REQ_ID FROM PIP_MAT_TRANSF WHERE TRANSF_ID=:TRANSF_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="ddlMatCode" Name="MAT_ID" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="CableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT NVL(CABLE_DRUM_NO,'NA') AS CABLE_DRUM_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID =:MAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT NVL(HEAT_NO,'NA') AS HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID =:MAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlMrItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MR_ITEM_NO  FROM MATERIAL_REQUEST_DETAIL WHERE MAT_ID =:MAT_ID AND MAT_REQ_ID 
                         IN (SELECT MAT_REQ_ID FROM PIP_MAT_TRANSF WHERE TRANSF_ID = :TRANSF_ID) ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="HeatNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DrumNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="ChildDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MAT_TRANSFER_RCV_DT WHERE ((TRANSF_ID = :TRANSF_ID) AND (MR_ITEM_NO = :MR_ITEM_NO))"
        UpdateCommand="UPDATE PIP_MAT_TRANSFER_RCV_DT SET RCV_QTY = :RCV_QTY, HEAT_NO = :HEAT_NO, PAINT_SYS = :PAINT_SYS , CABLE_DRUM_NO = :CABLE_DRUM_NO
                             WHERE (RCV_ITEM_ID = :RCV_ITEM_ID)"
        DeleteCommand="DELETE FROM PIP_MAT_TRANSFER_RCV_DT WHERE RCV_ITEM_ID = :RCV_ITEM_ID">
        <SelectParameters>
            <asp:SessionParameter Name="TRANSF_ID" SessionField="TRANSF_ID" Type="Decimal" />
            <asp:SessionParameter Name="MR_ITEM_NO" SessionField="MR_ITEM_NO" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="RCV_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>

            <asp:Parameter Name="RCV_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="PAINT_SYS" Type="String" />
            <asp:Parameter Name="RCV_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
</asp:Content>
