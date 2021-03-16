<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POMaster.aspx.cs" Inherits="Procurement_POMaster" EnableSessionState="ReadOnly"%>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        /*.ctl00_ContentPlaceHolder1_itemsGrid_GridData{
            height:800px;
        }*/

        /*.rgDataDiv {
            height: 10% !important;
        }*/

        /*.MyGridClass .rgDataDiv {
            height: auto !important;
        }*/
    </style>

    <script type="text/javascript">
        //<![CDATA[

        function upload_pdf() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("PO_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=9&REF_ID=" + id, "RadWindow2", 650, 450);
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
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("podiv").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }
            //]]>
    </script>


    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="podiv" style="background-color: whitesmoke;">
        <table id="tb1" style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewPO" runat="server" Text="New PO" Icon-PrimaryIconUrl="~/Images/New-Icons/Window-Create.png" OnClick="btnNewPO_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPOHeader" runat="server" Text="PO Header" Icon-PrimaryIconUrl="~/Images/New-Icons/Window-Create.png" OnClick="btnPOHeader_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPOItems" runat="server" Text="PO Items" Icon-PrimaryIconUrl="~/Images/New-Icons/Window-Create.png" OnClick="btnPOItems_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPoBatches" runat="server" Text="PO Batches" OnClick="btnPoBatches_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPOSplit" runat="server" Text="PO Split Detail" Icon-PrimaryIconUrl="~/Images/New-Icons/Window-Create.png" OnClick="btnPOSplit_Click" Visible="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnPOSummary" runat="server" Text="PO Summary" OnClick="btnPOSummary_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnMiller" runat="server" Text="Miller Status" OnClick="btnMiller_Click" Visible="false">
                        <Icon PrimaryIconUrl="../Images/New-Icons/excel.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnUnderSRN" runat="server" Text="Under SRN" OnClick="btnUnderSRN_Click" Visible="false">
                        <Icon PrimaryIconUrl="../Images/New-Icons/excel.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Print PO" Icon-PrimaryIconUrl="~/Images/New-Icons/document-Print-Preview.png" OnClick="btnPreview_Click"></telerik:RadButton>

                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import"></telerik:RadButton>
                    </asp:LinkButton>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files"  OnClick="btnDownload_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnVariationPO" runat="server" Text="Variation Order" OnClick="btnVariationPO_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnImportExcel" runat="server" Text="Bulk Import"  OnClick="btnImportExcel_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                       <telerik:RadButton ID="btnReplacePoItem" runat="server" Text="Tag/PO Items Replace"  OnClick="btnReplacePoItem_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                           </telerik:RadButton>
                     <telerik:RadButton ID="btnExpeditor" runat="server" Text="Expeditors Emails" OnClick="btnExpeditor_Click"></telerik:RadButton>
                    


                </td>
                <td style="text-align: right">
                    <telerik:RadSearchBox ID="txtSearchPO" runat="server" Width="250px" EmptyMessage="Search PO.." Visible="false"></telerik:RadSearchBox>
                </td>


            </tr>
        </table>
    </div>
 <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div>
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None"
            OnDataBinding="itemsGrid_DataBinding"
            AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" PageSize="50" AllowSorting="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            OnItemDataBound="itemsGrid_ItemDataBound" PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)" OnItemCommand="itemsGrid_ItemCommand" OnPreRender="itemsGrid_PreRender">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" PageSize="50" DataKeyNames="PO_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                AllowFilteringByColumn="true" EditMode="InPlace" AllowMultiColumnSorting="true" ClientDataKeyNames="PO_ID" TableLayout="Fixed">
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

                    <telerik:GridTemplateColumn HeaderText="PDF"  AllowFiltering="false" AllowSorting="true" SortExpression="PDF_FLAG">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <%-- <telerik:GridBoundColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE"
                        SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>--%>

                    <telerik:GridTemplateColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE"
                        SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlDiscEdit" runat="server" DataSourceID="sqlDiscSource"
                                DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DISCIPLINELabel" runat="server" Text='<%# Eval("DISCIPLINE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_WORK_TYPE" FilterControlAltText="Filter PO_WORK_TYPE column" HeaderText="PO WORK TYPE"
                        SortExpression="PO_WORK_TYPE" UniqueName="PO_WORK_TYPE" AutoPostBackOnFilter="true" 
                        FilterControlWidth="70px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER"  
                        SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" ReadOnly="true"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                    </telerik:GridBoundColumn>--%>
                    <%--   --%>
                    <telerik:GridTemplateColumn DataField="PO_NO" HeaderText="PO Number" SortExpression="PO_NO" UniqueName="PO_NO" FilterControlWidth="120px" AutoPostBackOnFilter="true" ReadOnly="true" >
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PO_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.PO_NO") %>'>
                            </asp:Label>
                            <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="Label1" Width="150px"
                                Font-Size="Larger" RelativeTo="Element" Position="TopCenter">
                                Buyer: <%# DataBinder.Eval(Container, "DataItem.BUYER") %>
                                <br />
                                Expeditor: <%# DataBinder.Eval(Container, "DataItem.EXPEDITOR") %>
                            </telerik:RadToolTip>

                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MR_NO" FilterControlAltText="Filter MR_NO column" HeaderText="MR NO" ReadOnly="true"
                        SortExpression="MR_NO" UniqueName="MR_NO" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <%--  --%>
                    <telerik:GridBoundColumn DataField="PO_SUBJECT" FilterControlAltText="Filter PO_SUBJECT column" HeaderText="PO SUBJECT"
                        SortExpression="PO_SUBJECT" UniqueName="PO_SUBJECT" AutoPostBackOnFilter="true" FilterControlWidth="150px">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                   <telerik:GridTemplateColumn DataField="PO_DATE" DataType="System.DateTime" FilterControlAltText="Filter PO_DATE column"
                                HeaderText="PO DATE" SortExpression="PO_DATE" UniqueName="PO_DATE" EnableHeaderContextMenu="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtPO_DATE" runat="server" DbSelectedDate='<%# Bind("PO_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="PO_DATELabel" runat="server" Text='<%# Eval("PO_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_REVISION" AllowFiltering="false" FilterControlAltText="Filter PO_REVISION column"
                        HeaderText="PO REV" SortExpression="PO_REVISION" UniqueName="PO_REVISION">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_VEND_NAME" AutoPostBackOnFilter="true" FilterControlAltText="Filter PO_VEND_NAME column"
                        HeaderText="VENDOR NAME" SortExpression="PO_VEND_NAME" UniqueName="PO_VEND_NAME"  FilterControlWidth="120px">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" AutoPostBackOnFilter="true" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT"
                        ReadOnly="true" FilterControlWidth="40px">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="PO_VEND_PHONE" AllowFiltering="false" FilterControlAltText="Filter PO_VEND_PHONE column" HeaderText="VENDOR PHONE" SortExpression="PO_VEND_PHONE" UniqueName="PO_VEND_PHONE">
                    </telerik:GridBoundColumn>  --%>
                   <telerik:GridTemplateColumn DataField="PO_CDD" DataType="System.DateTime" FilterControlAltText="Filter PO_CDD column"
                                HeaderText="PO CDD" SortExpression="PO_CDD" UniqueName="PO_CDD" EnableHeaderContextMenu="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtPO_CDD" runat="server" DbSelectedDate='<%# Bind("PO_CDD") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="PO_CDDLabel" runat="server" Text='<%# Eval("PO_CDD", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_DESTINATION" AllowFiltering="false" FilterControlAltText="Filter PO_DESTINATION column" HeaderText="PO DESTINATION" SortExpression="PO_DESTINATION" UniqueName="PO_DESTINATION">
                        <ItemStyle Width="160px" />
                        <HeaderStyle Width="160px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BUYER" AllowFiltering="true" FilterControlAltText="Filter BUYER column" HeaderText="BUYER" SortExpression="BUYER" UniqueName="BUYER" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXPEDITOR" AllowFiltering="true" FilterControlAltText="Filter EXPEDITOR column" HeaderText="EXPEDITOR" SortExpression="EXPEDITOR" UniqueName="EXPEDITOR" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>



    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery" TypeName="Procurement_CTableAdapters.VIEW_ADAPTER_POTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearchPO" DefaultValue="%" Name="FILTER" PropertyName="Text" Type="String" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="PO_SUBJECT" Type="String" />
            <asp:Parameter Name="PO_REVISION" Type="String" />
            <asp:Parameter Name="PO_DESTINATION" Type="String" />
            <asp:Parameter Name="BUYER" Type="String" />
            <asp:Parameter Name="EXPEDITOR" Type="String" />
            <asp:Parameter Name="PO_WORK_TYPE" Type="String" />
            <asp:Parameter Name="PO_DATE" Type="DateTime" />
            <asp:Parameter Name="PO_VEND_NAME" Type="String" />
            <asp:Parameter Name="PO_CDD" Type="DateTime" />

        </UpdateParameters>

        <DeleteParameters>
            <asp:Parameter Name="Original_PO_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="posplitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_SPLIT_ADAPTER WHERE  (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="underSRNDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_SPLIT_ADAPTER WHERE  (PROJECT_ID = :PROJECT_ID) AND  SRN_NO IS NOT NULL AND   VIEW_PO_SPLIT_ADAPTER.SRN_NO NOT IN (SELECT DISTINCT Nvl(SRN_NO, 'XXX') FROM PRC_MAT_INSP_DETAIL)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDiscSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  *
FROM DISCIPLINE_DEF"></asp:SqlDataSource>
</asp:Content>

