<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PODetailSplit - Copy.aspx.cs" Inherits="Procurement_PODetailSplit" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width:100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnNew" runat="server" Text="Create Split" Width="120px"></telerik:RadButton>
                    <telerik:RadButton ID="btnDetail" runat="server" Text="Detail" Width="80px" OnClick="btnDetail_Click"></telerik:RadButton>
                </td>
                <td style="text-align:right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="250px" EmptyMessage="Search Item...." AutoPostBack="true"></telerik:RadTextBox>
                </td>
            </tr>
        </table>


    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" AllowPaging="true"
            PageSize="12">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="SPLIT_ITEM_ID">
                <Columns>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO_ITEM_NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_ID" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT_ID" SortExpression="SPLIT_ID" UniqueName="SPLIT_ID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ORD_QTY" DataType="System.Decimal" FilterControlAltText="Filter ORD_QTY column" HeaderText="ORD_QTY" SortExpression="ORD_QTY" UniqueName="ORD_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_QTY column" HeaderText="SPLIT_QTY" SortExpression="SPLIT_QTY" UniqueName="SPLIT_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_EXTRA_QTY" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_EXTRA_QTY column" HeaderText="SPLIT_EXTRA_QTY" SortExpression="SPLIT_EXTRA_QTY" UniqueName="SPLIT_EXTRA_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CDD" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter CDD column" HeaderText="CDD" SortExpression="CDD" UniqueName="CDD">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="SRN_NO" SortExpression="SRN_NO" UniqueName="SRN_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIPPED_QTY" DataType="System.Decimal" FilterControlAltText="Filter SHIPPED_QTY column" HeaderText="SHIPPED_QTY" SortExpression="SHIPPED_QTY" UniqueName="SHIPPED_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BALANCE_QTY_TO_RELEASE" DataType="System.Decimal" FilterControlAltText="Filter BALANCE_QTY_TO_RELEASE column" HeaderText="BALANCE_QTY_TO_RELEASE" SortExpression="BALANCE_QTY_TO_RELEASE" UniqueName="BALANCE_QTY_TO_RELEASE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA_DATE" FilterControlAltText="Filter ETA_DATE column" HeaderText="ETA_DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_BTableAdapters.VIEW_PO_SPLIT_DETAILTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

