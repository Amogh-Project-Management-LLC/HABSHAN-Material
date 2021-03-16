<%@ Page Title="Material Request" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestItems.aspx.cs" Inherits="Material_MaterialRequestItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
            }
            function RowDblClickCancel(sender, eventArgs) {
                return false;
            }
            function handleSpace(event) {
                var keyPressed = event.which || event.keyCode;
                if (keyPressed == 13) {
                    event.preventDefault();
                    event.stopPropagation();
                }
            }
            function itemDetail() {
                try {
                    var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MAT_REQ_ID");
                    var id1 = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MR_ITEM_NO");
                    radopen("MaterialRequestDetail.aspx?MAT_REQ_ID=" + id + "&MR_ITEM_NO=" + id1, "RadWindow2", 650, 550);
                }
                catch (err) {
                    txt = "Select any row!";
                    alert(txt);
                }
            }

            function RefreshParent(sender, eventArgs) {
                location.href = location.href;
            }

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
                grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 65 + "px";
                grid.get_element().style.width = width - 20 + "px";
                grid.repaint();
                console.log("H:" + height + " W:" + width);
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

            //]]>
        </script>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    </telerik:RadCodeBlock>
    <div id="HeaderButtons">
        <table>
            <tr>
                <td style="background-color: gainsboro">
                    <table>
                        <tr>

                            <td>
                                <telerik:RadButton ID="btnBack" runat="server" CausesValidation="False" OnClick="btnBack_Click" Text="Back" Width="80px" />
                            </td>
                            <td>
                                <asp:ImageButton ID="ImageButtonDetails" runat="server" ImageUrl="~/Images/icons/show-menu-icon.png" OnClientClick="itemDetail(); return false;" Visible="false" />
                            </td>
                            <td>
                                <telerik:RadButton ID="btnEntry" runat="server" CausesValidation="False" OnClick="btnEntry_Click" Text="Add Items" Width="100px" />
                            </td>
                            <td>
                                <telerik:RadButton ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Save" Visible="False" Width="80px" ValidationGroup="Submit"/>
                            </td>
                            <td>
                                <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" ForeColor="Red" Visible="false"
                                    OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
                                </telerik:RadButton>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="10">
                                            <ProgressTemplate>
                                                <img alt="loading" src="../Images/ajax-loader-bar.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <table style="width: 100%">

        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%" id="EntryTable" runat="server" visible="false">
                            <tr>
                                <td style="width: 150px; background-color: gainsboro">Item Code
                                </td>
                                <td>
                                    <%-- 
                                       <telerik:RadTextBox ID="txtMatCode" runat="server" Width="210px" AutoPostBack="True" OnTextChanged="txtMatCode_TextChanged" CausesValidation="false"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="codeValidator" runat="server" ControlToValidate="txtMatCode"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                    --%>

                                    <telerik:RadComboBox ID="ddlMatCode" runat="server" DataSourceID="MatDataSource" DataTextField="MAT_CODE1" AllowCustomText="true"
                                        Filter="Contains" DataValueField="MAT_ID" Width="250px" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged"
                                        AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Matcode"
                                        ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px; background-color: gainsboro">PO Number
                                </td>
                                <td>
                                    <telerik:RadDropDownList ID="ddlPO" DataSourceID="MatPODataSource" DataTextField="PO_NO" DataValueField="PO_ID" runat="server"></telerik:RadDropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px; background-color: gainsboro">MR Item Number
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtMrItem" runat="server" Width="100px"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="MrItemValidator" runat="server" ControlToValidate="txtMrItem" ValidationGroup="Submit"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: gainsboro;">Item Description</td>
                                <td>
                                    <telerik:RadTextBox ID="txtItemDescr" runat="server" Width="350px" TextMode="MultiLine" Enabled="false"></telerik:RadTextBox></td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: gainsboro;">Heat No</td>
                                <td>
                                    <%--<telerik:RadTextBox ID="txtHeatNo" runat="server" Width="150px" TextMode="SingleLine"></telerik:RadTextBox>--%>

                                    <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO"
                                        DataValueField="HEAT_NO" OnDataBinding="txtHeatNo_DataBinding">
                                    </telerik:RadDropDownList>


                                </td>
                            </tr>
                            <tr>
                                <td style="width: 120px; background-color: gainsboro;">Cable Drum No</td>
                                <td>
                                    <%--<telerik:RadTextBox ID="txtCabledrum" runat="server" Width="150px" TextMode="SingleLine"></telerik:RadTextBox>--%>
                                    <telerik:RadDropDownList ID="txtCabledrum" DataSourceID="SqlDataSource1"
                                        DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" runat="server">
                                    </telerik:RadDropDownList>

                                </td>
                            </tr>
                            <tr>
                                <td style="width: 180px; background-color: gainsboro">Required Qty
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtReqQty" runat="server" Width="100px"></telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtReqQty" ValidationGroup="Submit"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 180px; background-color: gainsboro">Required Date
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="txtReqDate" runat="server" Width="100px"></telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="ReqDateValidator" runat="server" ControlToValidate="txtReqDate" ValidationGroup="Submit"
                                        ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 180px; background-color: gainsboro">Required at Location
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtRqrdAtLocation" runat="server" Width="200px"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 150px; background-color: gainsboro">Remarks
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="450px"></telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="itemstDataSource" AllowPaging="true" PageSize="50" Height="330px" AllowFilteringByColumn="true"
                            AllowSorting="true" OnItemCommand="RadGrid1_ItemCommand" onkeypress="handleSpace(event)" OnItemDeleted="RadGrid1_ItemDeleted" OnPreRender="RadGrid1_PreRender"
                            OnItemDataBound="RadGrid1_ItemDataBound" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true" AllowMultiRowSelection="true"
                            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                            </ClientSettings>
                            <ClientSettings AllowKeyboardNavigation="true">
                                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>

                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="MAT_REQ_ID,MR_ITEM_NO" DataSourceID="itemstDataSource"
                                AllowAutomaticDeletes="true" ClientDataKeyNames="MAT_REQ_ID,MR_ITEM_NO" AllowMultiColumnSorting="true"
                                PagerStyle-AlwaysVisible="true" TableLayout="Fixed" EditMode="InPlace">
                                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                        <ItemStyle Width="55px" />
                                        <HeaderStyle Width="55px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" UniqueName="DeleteColumn">
                                        <ItemStyle Width="35px" />
                                        <HeaderStyle Width="35px" />
                                    </telerik:GridButtonColumn>
                                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                                        <HeaderStyle Width="35px" />
                                        <ItemStyle Width="35px" />
                                    </telerik:GridClientSelectColumn>
                                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" DataType="System.Decimal" FilterControlAltText="Filter MR_ITEM_NO column"
                                        HeaderText="MR ITEM" SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO" AutoPostBackOnFilter="true" FilterControlWidth="35px">
                                        <ItemStyle Width="80px" />
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <%-- <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column"
                                        HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="true">
                                        <ItemStyle Width="180px" />
                                        <HeaderStyle Width="180px" />
                                    </telerik:GridBoundColumn>--%>
                                    <%--  <telerik:GridTemplateColumn UniqueName="PO_NO" HeaderText="PO NO"
                                        SortExpression="PO_NO" >
                                        <FooterTemplate>footer</FooterTemplate>
                                        <FooterStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <%#DataBinder.Eval(Container.DataItem, "PO_NO")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox RenderMode="Lightweight" runat="server" ID="RadComboBox1" EnableLoadOnDemand="True" DataTextField="PO_NO"
                                                OnItemsRequested="RadComboBox1_ItemsRequested" DataValueField="PO_ID" AutoPostBack="true"
                                                HighlightTemplatedItems="true" Height="140px" Width="100px" DropDownWidth="420px"
                                                OnSelectedIndexChanged="OnSelectedIndexChangedHandler">
                                                <HeaderTemplate>
                                                    <ul>
                                                        <li class="col1">PO NO</li>
                                                    </ul>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <ul>
                                                        <li class="col1">
                                                            <%# DataBinder.Eval(Container, "Text")%>
                                        </li>

                                                    </ul>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemStyle Width="150px" />
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridTemplateColumn>--%>

                                    <telerik:GridTemplateColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                                        SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="false">
                                        <ItemStyle Width="250px" />
                                        <HeaderStyle Width="250px" />
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="rcbPO" runat="server" DataSourceID="PODataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
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

                                    <%--  <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE"
                                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="80px" ReadOnly="true" AutoPostBackOnFilter="true">
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
                                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="200px" ReadOnly="true" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="300px" />
                                        <HeaderStyle Width="300px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AllowFiltering="false" ReadOnly="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column" HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO"
                                        AllowFiltering="false">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO"
                                        AllowFiltering="false">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" ReadOnly="true"
                                        AllowFiltering="false">
                                        <ItemStyle Width="60px" />
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                                        SortExpression="WALL_THK" UniqueName="WALL_THK" ReadOnly="true"
                                        AllowFiltering="false">
                                        <ItemStyle Width="60px" />
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="REQ_QTY" DataType="System.Decimal" FilterControlAltText="Filter REQ_QTY column" HeaderText="REQ QTY"
                                        SortExpression="REQ_QTY" UniqueName="REQ_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                                        <HeaderStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME" ReadOnly="true"
                                        AllowFiltering="false">
                                        <ItemStyle Width="60px" />
                                        <HeaderStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RQRD_DATE" DataType="System.DateTime" FilterControlAltText="Filter RQRD_DATE column" HeaderText="REQUIRED DATE"
                                        SortExpression="RQRD_DATE" UniqueName="RQRD_DATE" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false" ReadOnly="true">
                                        <ItemStyle Width="110px" />
                                        <HeaderStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ETA_DATE" DataType="System.DateTime" FilterControlAltText="Filter ETA_DATE column"
                                        HeaderText="ETA DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE" AllowFiltering="false" ReadOnly="true">
                                        <ItemStyle Width="110px" />
                                        <HeaderStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ATA_DATE" DataType="System.DateTime" FilterControlAltText="Filter ATA_DATE column" HeaderText="ATA DATE"
                                        SortExpression="ATA_DATE" UniqueName="ATA_DATE" AllowFiltering="false" ReadOnly="true">
                                        <ItemStyle Width="110px" />
                                        <HeaderStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                                        <ItemStyle Width="200px" />
                                        <HeaderStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <HeaderStyle HorizontalAlign="Center" />
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MATERIAL_REQUEST_DTTableAdapter"
        UpdateMethod="UpdateQuery1">
        <UpdateParameters>

            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REQ_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="PO_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_ID" Type="Decimal" />
            <asp:Parameter Name="MR_ITEM_NO" Type="Decimal" />
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MR_ITEM_NO" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_REQ_ID" QueryStringField="MAT_REQ_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="Original_MR_ITEM_NO" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>


    <asp:SqlDataSource ID="MatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT MAT_CODE1,MAT_ID FROM VIEW_MRIR_MAT_SOURCE"></asp:SqlDataSource>
    <asp:HiddenField ID="hiddenreqStoreID" runat="server" />
    <asp:SqlDataSource ID="MatPODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT PO_NO,PO_ID FROM VIEW_MRIR_MAT_SOURCE
                        WHERE MAT_ID=:MAT_ID ">
        <SelectParameters>

            <asp:ControlParameter ControlID="ddlMatCode" Name="MAT_ID" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT nvl(CABLE_DRUM_NO,'NA') as CABLE_DRUM_NO  FROM
                               PIP_MAT_RECEIVE,PIP_MAT_RECEIVE_DETAIL
                            WHERE PIP_MAT_RECEIVE.MAT_RCV_ID = PIP_MAT_RECEIVE_DETAIL.MAT_RCV_ID
                            AND  MAT_ID=:MAT_ID AND STORE_ID=:REQSTOREID UNION SELECT '' FROM DUAL">
        <SelectParameters>
            <asp:ControlParameter ControlID="hiddenreqStoreID" Name="reqStoreID" PropertyName="Value" DefaultValue="-1" />
            <asp:ControlParameter ControlID="ddlMatCode" Name="MAT_ID" PropertyName="SelectedValue" DefaultValue="-1" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT NVL(HEAT_NO,'NA') AS HEAT_NO FROM PRC_MAT_INSP_DETAIL WHERE MAT_ID =:MAT_ID UNION SELECT '' FROM DUAL ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="PODataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PO_ID,PO_NO FROM PIP_PO"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MATERIALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_ID,MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
</asp:Content>

