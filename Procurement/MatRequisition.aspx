<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatRequisition.aspx.cs" Inherits="Procurement_MatRequisition" EnableSessionState="ReadOnly"%>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }


        function callBackFn(arg) {
            alert("this is the client-side callback function. The RadAlert returned: " + arg);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MR_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=8&REF_ID=" + id, "RadWindow2", 650, 450);
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

        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        ////grid size//////////////////////
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }

        ////////grid size////////////////////
            //]]>
    </script>
    <%--  <style type="text/css">
      .rgDataDiv {
            min-height: 500px !important;
        }
      div.RadGrid .rgDataDiv {
        overflow-y: scroll!important;
    }
    </style>--%>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton runat="server" ID="btnAdd" Text="New MR" Width="80px"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnItems" Text="Items" Width="80px" OnClick="btnItems_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnExport" Text="Download" OnClick="btnExport_Click">
                        <Icon PrimaryIconUrl="../Images/icons/icon-save2.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnImportExcel" runat="server" Text="Bulk Import" OnClick="btnImportExcel_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>

                    <telerik:RadButton ID="btnPreview" runat="server" Text="Print MR" Icon-PrimaryIconUrl="~/Images/New-Icons/document-Print-Preview.png" OnClick="btnPreview_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnPOBal" runat="server" Text="PO Not Placed"  OnClick="btnPOBal_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                </td>

                <%-- <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="200px" EmptyMessage="Search MR..."></telerik:RadTextBox>
                </td>--%>
            </tr>
        </table>

    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>

    <asp:UpdatePanel runat="server" ID="updatePanel1">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="HeaderDataSource" Font-Size="9pt" 
                    AllowSorting="True" PagerStyle-AlwaysVisible="true" AllowPaging="True" PageSize="50" OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding"
                    OnItemDataBound="itemsGrid_ItemDataBound" onkeypress="handleSpace(event)" OnFilterCheckListItemsRequested="RadGrid_FilterCheckListItems"
                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FilterType="HeaderContext" OnPreRender="itemsGrid_PreRender">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                    </ClientSettings>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>
                    <MasterTableView AutoGenerateColumns="False" DataKeyNames="MR_ID" DataSourceID="HeaderDataSource"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="MR_ID" EditMode="InPlace" TableLayout="Fixed"
                        AllowFilteringByColumn="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>

                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn" EnableHeaderContextMenu="false">
                                <ItemStyle Width="55px" />
                                <HeaderStyle Width="55px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn UniqueName="DeleteColumn" ButtonType="ImageButton" CommandName="Delete" EnableHeaderContextMenu="false">
                                <ItemStyle Width="30px" />
                                <HeaderStyle Width="30px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn HeaderText="PDF" EnableHeaderContextMenu="true" AllowFiltering="false"  SortExpression="PDF_FLG">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE"
                                UniqueName="DISCIPLINE" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                                <EditItemTemplate>
                                    <telerik:RadDropDownList ID="ddlDiscEdit" runat="server" DataSourceID="sqlDiscSource"
                                        DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" AppendDataBoundItems="true" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                        SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                                        <Items>
                                            <telerik:DropDownListItem Text="(Select)" Value="" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="DISCIPLINELabel" runat="server" Text='<%# Eval("DISCIPLINE") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="MR_NO" FilterControlAltText="Filter MR_NO column" HeaderText="MR NO"
                                SortExpression="MR_NO" UniqueName="MR_NO" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                                <ItemStyle Width="160px" />
                                <HeaderStyle Width="160px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="MR_REV" FilterControlAltText="Filter MR_REV column" HeaderText="REV NO" SortExpression="MR_REV" UniqueName="MR_REV" EnableHeaderContextMenu="false">
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MR_TITLE" FilterControlAltText="Filter MR_TITLE column" HeaderText="MR TITLE"
                                SortExpression="MR_TITLE" UniqueName="MR_TITLE" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <%--   <telerik:GridBoundColumn DataField="DISCIPLINE_CODE" FilterControlAltText="Filter DISCIPLINE_CODE column" HeaderText="DISCIPLINE CODE" SortExpression="DISCIPLINE_CODE" UniqueName="DISCIPLINE_CODE" ReadOnly="True"  AutoPostBackOnFilter="true">
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="STATUS" SortExpression="STATUS" UniqueName="STATUS" EnableHeaderContextMenu="false">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>
                            
                            <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" ReadOnly="true" EnableHeaderContextMenu="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="MR_DATE" DataType="System.DateTime" FilterControlAltText="Filter MR_DATE column"
                                HeaderText="MR DATE" SortExpression="MR_DATE" UniqueName="MR_DATE" EnableHeaderContextMenu="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtDateEdit" runat="server" DbSelectedDate='<%# Bind("MR_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="MR_DATELabel" runat="server" Text='<%# Eval("MR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridTemplateColumn>
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

                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


   <%-- <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="Procurement_BTableAdapters.VIEW_ADAPTER_MRTableAdapter" UpdateMethod="UpdateQuery"></asp:ObjectDataSource>--%>

    <asp:SqlDataSource ID="HeaderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT *FROM VIEW_ADAPTER_MR
                            WHERE (VIEW_ADAPTER_MR.PROJECT_ID = :PROJECT_ID) AND
                            (
                            (ACCESS_BY=(SELECT  ACCESS_BY FROM USERS WHERE USER_NAME=:USER_NAME) )
                            OR
                             ('Y'=(SELECT ALL_RECORDS FROM USERS WHERE USER_NAME=:USER_NAME))
                            )
                        ORDER BY MR_NO DESC"
        DeleteCommand="DELETE FROM PIP_MAT_REQUISITION WHERE  (MR_ID = :MR_ID)"
        UpdateCommand="UPDATE PIP_MAT_REQUISITION
                        SET       MR_NO = :MR_NO, MR_REV = :MR_REV, MR_TITLE = :MR_TITLE, STATUS = :STATUS, REMARKS = :REMARKS, DISCIPLINE_ID = :DISCIPLINE_ID , 
                                  MR_DATE =:MR_DATE ,CREATE_BY =:USER_ID
                        WHERE (MR_ID = :MR_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="MR_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="MR_NO" Type="String" />
            <asp:Parameter Name="MR_REV" Type="String" />
            <asp:Parameter Name="MR_TITLE" Type="String" />
            <asp:Parameter Name="STATUS" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MR_DATE" Type="DateTime" />
            <asp:Parameter Name="USER_ID" Type="Decimal" />
            <asp:Parameter Name="MR_ID" Type="Decimal" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDownload" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MR_NO, MR_REV, MR_TITLE, DISCIPLINE_CODE, STATUS, MR_ITEM_NO,     ITEM_OCCURENCE, TAG_NO, CLIENT_PART_NO, ITEM_DESCR, 
        MR_QTY,PREV_QTY, DELTA_QTY, DELIVERY_POINT, CONSTRUCTION_AREA FROM VIEW_MAT_REQUISITION WHERE (
        (ACCESS_BY=(SELECT  ACCESS_BY FROM USERS WHERE USER_NAME=:USER_NAME) )
           OR
         ('Y'=(SELECT ALL_RECORDS FROM USERS WHERE USER_NAME=:USER_NAME))        
         )">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPOBalance" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_MR_PO_BALANCE WHERE PO_BALANCE<>0"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDiscSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  *
FROM DISCIPLINE_DEF"></asp:SqlDataSource>
     <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME ,USER_ID FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>

</asp:Content>

