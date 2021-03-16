<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POInspDetail.aspx.cs" Inherits="Procurement_POInspDetail" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test()
        {
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
    <div style="margin-top:2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowSorting="true" PageSize="50"
             OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding"  onkeypress="handleSpace(event)">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="REQ_ITEM_ID"
                 AllowMultiColumnSorting="true"  AllowPaging="true" 
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton" ConfirmText="Are you sure you want to delete ?">
                         <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                     <telerik:GridBoundColumn DataField="AREA" FilterControlAltText="Filter AREA column" HeaderText="AREA" SortExpression="AREA" 
                         UniqueName="AREA" AllowFiltering="false" ReadOnly="true">
                          <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_AREA" FilterControlAltText="Filter SUB_AREA column" HeaderText="SUB AREA" 
                        SortExpression="SUB_AREA" UniqueName="SUB_AREA" AllowFiltering="false" ReadOnly="true">
                         <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" ReadOnly="true" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" 
                        SortExpression="PO_ITEM" UniqueName="PO_ITEM">
                         <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" 
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                  <%--  <telerik:GridBoundColumn DataField="MAT_CODE2" ReadOnly="true" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" ReadOnly="true" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" HeaderText="QTY" 
                        SortExpression="INSP_QTY" UniqueName="INSP_QTY" DataFormatString="{0:N2}">
                         <ItemStyle Width="60px" HorizontalAlign="Right" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" ReadOnly="true" FilterControlAltText="Filter UOM column" HeaderText="UoM" SortExpression="UOM" 
                        UniqueName="UOM">
                         <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" 
                        UniqueName="REMARKS">
                         <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_INSP_REQUEST_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_REQ_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REQ_ID" QueryStringField="REQ_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="INSP_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_REQ_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

