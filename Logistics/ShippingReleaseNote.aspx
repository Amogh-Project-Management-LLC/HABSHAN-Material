<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShippingReleaseNote.aspx.cs" Inherits="Logistics_ShippingReleaseNote" %>

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
        <table style="width:100%">
            <tr>
                <td>
                    <telerik:RadButton runat="server" ID="btnAdd" Text="New Packing List" Width="150px"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnItems" Text="Material List" Width="120px" OnClick="btnItems_Click"></telerik:RadButton>
                    <telerik:RadDropDownList ID="ddlReportList" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="(Select)" Value="" />
                            <telerik:DropDownListItem Text="SCN Cover Page" Value="11" />
                            <telerik:DropDownListItem Text="Packing List" Value="12" />
                        </Items>
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="text-align:right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="250px" EmptyMessage="Search SRN Number....."></telerik:RadTextBox>
                </td>
            </tr>
        </table>

    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
            AllowPaging="true" PageSize="50" AllowFilteringByColumn="true" AllowSorting="true" OnItemCommand="itemsGrid_ItemCommand"
            OnDataBinding="itemsGrid_DataBinding" onkeypress="handleSpace(event)">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="SRN_ID" AllowMultiColumnSorting="true"
                 TableLayout="Fixed">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" >
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="PL NO" SortExpression="SRN_NO" 
                        UniqueName="SRN_NO"  FilterControlWidth="150px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" SortExpression="PO_NO" 
                        UniqueName="PO_NO"  FilterControlWidth="150px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_DATE" DataType="System.DateTime" FilterControlAltText="Filter SRN_DATE column" HeaderText="PACKING DATE"
                        DataFormatString="{0:dd-MMM-yyyy}" SortExpression="SRN_DATE" UniqueName="SRN_DATE"  FilterControlWidth="60px">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_DELIVERY_POINT" FilterControlAltText="Filter SRN_DELIVERY_POINT column" 
                        HeaderText="DELIVERY POINT" SortExpression="SRN_DELIVERY_POINT" UniqueName="SRN_DELIVERY_POINT" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SCN_NO" FilterControlAltText="Filter SCN_NO column" HeaderText="SCN_NO"
                        SortExpression="SCN_NO" UniqueName="SCN_NO"  FilterControlWidth="150px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="SRN_REV" DataType="System.Decimal" FilterControlAltText="Filter SRN_REV column" 
                        HeaderText="REV NO" SortExpression="SRN_REV" UniqueName="SRN_REV"  FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_REMARKS" FilterControlAltText="Filter SRN_REMARKS column" HeaderText="REMARKS" 
                        SortExpression="SRN_REMARKS" UniqueName="SRN_REMARKS"  FilterControlWidth="150px">
                    </telerik:GridBoundColumn>
                   
                    <telerik:GridBoundColumn DataField="SRN_INSP_DATE" Visible="false" DataType="System.DateTime" FilterControlAltText="Filter SRN_INSP_DATE column" HeaderText="SRN_INSP_DATE" SortExpression="SRN_INSP_DATE" UniqueName="SRN_INSP_DATE" ItemStyle-Width="30px"  FilterControlWidth="50px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsLogistics_ATableAdapters.VIEW_PRC_SRN_MASTERTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_SRN_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

