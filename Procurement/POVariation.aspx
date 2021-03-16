<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POVariation.aspx.cs" Inherits="Procurement_POMaster" %>

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
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("VO_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=30&REF_ID=" + id, "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
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
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            grid.get_element().style.width = width - 15 + "px";

            grid.repaint();
        }
            //]]>
    </script>


    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnVOItems" runat="server" Text="Variation Items" Width="150px" OnClick="btnVOItems_Click"></telerik:RadButton>
        <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
            <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
        </asp:LinkButton>
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None"
            AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" PageSize="50" AllowSorting="true" OnItemDataBound="itemsGrid_ItemDataBound" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" PageSize="50" DataKeyNames="VO_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                AllowFilteringByColumn="true" EditMode="InPlace" AllowMultiColumnSorting="true" ClientDataKeyNames="VO_ID" TableLayout="Fixed">
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

                    <telerik:GridTemplateColumn AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                        SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" FilterControlWidth="100px" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <%--  --%>
                    <telerik:GridBoundColumn DataField="VO_NO" FilterControlAltText="Filter VO_NO column" HeaderText="VO NO"
                        SortExpression="VO_NO" UniqueName="VO_NO" AutoPostBackOnFilter="true" FilterControlWidth="100px" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_NAME" FilterControlAltText="Filter REV_NAME column" HeaderText="REV_NAME"
                        SortExpression="REV_NAME" UniqueName="REV_NAME" AllowFiltering="false">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_NO" FilterControlAltText="Filter REV_NO column" HeaderText="REV_NO"
                        SortExpression="REV_NO" UniqueName="REV_NO" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <%--<telerik:GridBoundColumn DataField="VO_DATE" AllowFiltering="false" DataType="System.DateTime"
                        FilterControlAltText="Filter VO_DATE column" HeaderText="VO DATE" SortExpression="VO_DATE" UniqueName="VO_DATE"
                        DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridTemplateColumn DataField="VO_DATE" DataType="System.DateTime" FilterControlAltText="Filter VO_DATE column"
                        HeaderText="VO DATE" SortExpression="VO_DATE" UniqueName="VO_DATE" EnableHeaderContextMenu="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtVO_DATEedit" runat="server" DbSelectedDate='<%# Bind("VO_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="VO_DATELabel" runat="server" Text='<%# Eval("VO_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="VARIATION_TYPE" AllowFiltering="false" FilterControlAltText="Filter VARIATION_TYPE column"
                        HeaderText="VARIATION TYPE" SortExpression="VARIATION_TYPE" UniqueName="VARIATION_TYPE">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VO_STATUS" AutoPostBackOnFilter="true" FilterControlAltText="Filter VO_STATUS column"
                        HeaderText="VO STATUS" SortExpression="VO_STATUS" UniqueName="VO_STATUS" FilterControlWidth="80px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="ITEM_COUNT" AutoPostBackOnFilter="true" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT"
                        ReadOnly="true" FilterControlWidth="50px" AllowFiltering="false">
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="VO_REMARKS" AutoPostBackOnFilter="true" FilterControlAltText="Filter VO_REMARKS column"
                        HeaderText="VO REMARKS" SortExpression="VO_REMARKS" UniqueName="VO_REMARKS" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery" TypeName="Procurement_CTableAdapters.VIEW_VO_MASTERTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" />
        </SelectParameters>
        <UpdateParameters>

            <asp:Parameter Name="REV_NAME" Type="String" />
            <asp:Parameter Name="REV_NO" Type="Decimal" />
            <asp:Parameter Name="VO_DATE" Type="DateTime" />
            <asp:Parameter Name="VARIATION_TYPE" Type="String" />
            <asp:Parameter Name="VO_STATUS" Type="String" />
            <asp:Parameter Name="VO_REMARKS" Type="String" />
            <asp:Parameter Name="Original_VO_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_VO_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>



