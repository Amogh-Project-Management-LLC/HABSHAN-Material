<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatWiseHeatNo.aspx.cs" Inherits="Mat_HeatNo_Received" Title="Heat No - MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ReceiveGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - 65 + "px";
            grid.get_element().style.width = width - 30 + "px";
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
    </script>

    <table style="background-color: whitesmoke;">
        <tr>
            <td>
                <div id="HeaderButtons">
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </div>
            </td>
            <td style="text-align: right;">
                <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                    Width="130px">
                </asp:DropDownList>
            </td>
        </tr>
    </table>


    <div>


        <telerik:RadGrid ID="ReceiveGridView" runat="server" CellSpacing="-1" AllowFilteringByColumn="true" AllowSorting="true"
            DataSourceID="receiveDataSource" AllowPaging="True" PageSize="50" onkeypress="handleSpace(event)"
            OnDataBound="ReceiveGridView_DataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowDragToGroup="True" AllowColumnsReorder="True">
                <Resizing AllowColumnResize="true"></Resizing>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="MAT_ID" AllowMultiColumnSorting="true"
                EnableHeaderContextMenu="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" PageSize="50" AllowFilteringByColumn="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>

                    <telerik:GridBoundColumn DataField="MIR_NO" HeaderText="Receive No" SortExpression="MIR_NO"
                        AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Receive Date"
                        HtmlEncode="False" SortExpression="INSP_DATE" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code"
                        SortExpression="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" SortExpression="WALL_THK" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="Item" SortExpression="ITEM_NAM" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" HeaderText="Heat Number" SortExpression="HEAT_NO" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" HeaderText="Recv'd Qty" SortExpression="RCV_QTY" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>

    </div>

    <asp:SqlDataSource ID="receiveDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM VIEW_MAT_MRIR_SUMMARY
WHERE ((PROJECT_ID = :PROJECT_ID) AND (MAT_ID = :MAT_ID))'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="~" Name="MAT_ID" QueryStringField="MAT_ID"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
