<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShippingReleaseNoteDetail.aspx.cs" Inherits="Logistics_ShippingReleaseNoteDetail" %>

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
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Width="120px" AutoPostBack="true">
                    </telerik:RadButton>
                  
                </td>
                <td style="text-align:right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="300px" EmptyMessage="Search Material...."></telerik:RadTextBox>
                </td>               
            </tr>
        </table>

    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
             AllowPaging="true" PageSize="50" Height="330px" AllowFilteringByColumn="true"  AllowSorting="true"
             OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding" onkeypress="handleSpace(event)">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowMultiColumnSorting="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="10px"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                         ConfirmTextFormatString="Are you sure you want to delete {0} ?" ConfirmTextFields="MAT_CODE1">
                        <ItemStyle Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="PKG_NO" FilterControlAltText="Filter PKG_NO column" HeaderText="PKG NO" SortExpression="PKG_NO" UniqueName="PKG_NO"  ItemStyle-Width="40px"  FilterControlWidth="60px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM"  ItemStyle-Width="20px"  AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_ID" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT ID" SortExpression="SPLIT_ID" UniqueName="SPLIT_ID"  ItemStyle-Width="20px"  AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1"  ItemStyle-Width="30px"  FilterControlWidth="50px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR"  ItemStyle-Width="60px"  FilterControlWidth="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM"  ItemStyle-Width="20px" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PKG_QTY" DataType="System.Decimal" FilterControlAltText="Filter PKG_QTY column" HeaderText="SRN QTY" SortExpression="PKG_QTY" UniqueName="PKG_QTY"  ItemStyle-Width="20px"  FilterControlWidth="30px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UNIT_NET_WT" DataType="System.Decimal" FilterControlAltText="Filter UNIT_NET_WT column" HeaderText="UNIT NET WT" SortExpression="UNIT_NET_WT" UniqueName="UNIT_NET_WT"  ItemStyle-Width="20px"  AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UNIT_GROSS_WT" DataType="System.Decimal" FilterControlAltText="Filter UNIT_GROSS_WT column" HeaderText="UNIT GROSS WT" SortExpression="UNIT_GROSS_WT" UniqueName="UNIT_GROSS_WT"  ItemStyle-Width="20px"  AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VOLUME" DataType="System.Decimal" FilterControlAltText="Filter VOLUME column" HeaderText="VOLUME" SortExpression="VOLUME" UniqueName="VOLUME"  ItemStyle-Width="30px"  FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ORIGIN" FilterControlAltText="Filter ORIGIN column" HeaderText="ORIGIN" SortExpression="ORIGIN" UniqueName="ORIGIN"  ItemStyle-Width="30px"  FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PACKING_TYPE" FilterControlAltText="Filter PACKING_TYPE column" HeaderText="PACKING_TYPE" SortExpression="PACKING_TYPE" UniqueName="PACKING_TYPE"  ItemStyle-Width="20px"  FilterControlWidth="30px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsLogistics_ATableAdapters.VIEW_SRN_DETAILTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SRN_ID" QueryStringField="SRN_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

