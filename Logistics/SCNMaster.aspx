<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SCNMaster.aspx.cs" Inherits="Logistics_SCNMaster" %>

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
    <div style="background-color: whitesmoke"  id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnNew" Text="New SCN" Width="90px"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnDetail" Text="SCN Detail" Width="90px" OnClick="btnDetail_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnPreview" Text="Preview" Width="90px" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"  AllowSorting="true"
            AllowPaging="True" PageSize="50" MasterTableView-EditMode="InPlace" Height="330px" AllowFilteringByColumn="true"
            OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding" onkeypress="handleSpace(event)">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="SCN_ID"
                 AllowMultiColumnSorting="true" TableLayout="Fixed">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="SCN_NO" FilterControlAltText="Filter SCN_NO column" HeaderText="SCN NO" SortExpression="SCN_NO"
                        UniqueName="SCN_NO"  FilterControlWidth="80px">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" ReadOnly="true" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NO" 
                        SortExpression="SHIP_NO" UniqueName="SHIP_NO"  FilterControlWidth="80px">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SCN_DATE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" 
                        FilterControlAltText="Filter SCN_DATE column" HeaderText="SCN DATE" SortExpression="SCN_DATE" UniqueName="SCN_DATE"  
                        FilterControlWidth="80px" >
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SCN_COMMIT_DISP" ReadOnly="true"  FilterControlAltText="Filter SCN_COMMIT_DISP column" 
                        HeaderText="SCN DISPATCH" SortExpression="SCN_COMMIT_DISP" UniqueName="SCN_COMMIT_DISP"  FilterControlWidth="80px">
                        <ItemStyle Width="135px" />
                        <HeaderStyle Width="135px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SCN_COMMIT_RCPT" ReadOnly="true" FilterControlAltText="Filter SCN_COMMIT_RCPT column" 
                        HeaderText="SCN RECEIPT" SortExpression="SCN_COMMIT_RCPT" UniqueName="SCN_COMMIT_RCPT"  FilterControlWidth="80px">
                        <ItemStyle Width="135px" />
                        <HeaderStyle Width="135px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" 
                        SortExpression="REMARKS" UniqueName="REMARKS"  FilterControlWidth="80px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsLogistics_ATableAdapters.VIEW_PRC_SCN_MASTERTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_SCN_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="SCN_NO" Type="String" />
            <asp:Parameter Name="SCN_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SCN_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

