<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POPunchlistDetail.aspx.cs" Inherits="Procurement_POPunchlistDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
        function handleSpace(event)
        {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13)
            {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowFilteringByColumn="True" CellSpacing="-1" DataSourceID="itemsDataSource"  onkeypress="handleSpace(event)" AllowSorting="true" PageSize="50">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="PUNCH_ID"
                AllowMultiColumnSorting="true" AllowPaging="true"
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ConfirmText="Are you sure you want to delete ?">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE"
                        UniqueName="DISCIPLINE" AllowFiltering="true" ReadOnly="true" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO"
                        UniqueName="PO_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ReadOnly="true" AllowFiltering="True">
                        <ItemStyle Width="170px" />
                        <HeaderStyle Width="170px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PUNCH_NO" ReadOnly="true" FilterControlAltText="Filter PUNCH_NO column" HeaderText="PUNCH NUMBER"
                        SortExpression="PUNCH_NO" UniqueName="PUNCH_NO" FilterControlWidth="150px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <%--  <telerik:GridBoundColumn DataField="MAT_CODE2" ReadOnly="true" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" ReadOnly="true" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    <ItemStyle Width="270px" />
                    <HeaderStyle Width="270px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" ReadOnly="true" FilterControlAltText="Filter QTY column" HeaderText="QTY" SortExpression="QTY" UniqueName="QTY" FilterControlWidth="30px">
                    <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CATEGORY" ReadOnly="true" FilterControlAltText="Filter CATEGORY column" HeaderText="CATEGORY" SortExpression="CATEGORY" UniqueName="CATEGORY" FilterControlWidth="50px">
                    <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DESCR" ReadOnly="true" FilterControlAltText="Filter DESCR column" HeaderText="PUNCH DESCRIPTION" SortExpression="DESCR" UniqueName="DESCR" FilterControlWidth="100px">
                    <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" ReadOnly="true" FilterControlAltText="Filter CREATE_DATE column" HeaderText="PUNCH DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" FilterControlWidth="100px">
                    <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS"
                        UniqueName="REMARKS">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PUNCHLIST_MASTER_DTTableAdapter" UpdateMethod="UpdateQuery">
        <%--<DeleteParameters>
            <asp:Parameter Name="original_PUNCH_ID" Type="Decimal" />
        </DeleteParameters>--%>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PUNCH_ID" QueryStringField="PUNCH_ID" Type="Decimal" />
        </SelectParameters>
        <%--<UpdateParameters>
            <asp:Parameter Name="INSP_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_REQ_ITEM_ID" Type="Decimal" />
        </UpdateParameters>--%>
    </asp:ObjectDataSource>
</asp:Content>

