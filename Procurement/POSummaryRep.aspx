<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POSummaryRep.aspx.cs" Inherits="Procurement_PODetails" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="80px">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Visible="false"></telerik:RadButton>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="True"  AllowSorting="true" PagerStyle-AlwaysVisible="true"
            PageSize="50" AllowFilteringByColumn="true" Height="330px" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true" >
              <HeaderStyle HorizontalAlign="Center"  /> 
            <ClientSettings>
                <Scrolling UseStaticHeaders="true" AllowScroll="true"/>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowMultiColumnSorting="true">
                <Columns>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="true" AutoPostBackOnFilter="true" ItemStyle-Width="40px">
                    </telerik:GridBoundColumn> 
                     <telerik:GridBoundColumn DataField="ITEM_NAME" FilterControlAltText="Filter ITEM_NAME column" HeaderText="ITEM NAME" SortExpression="ITEM_NAME" UniqueName="ITEM_NAME" AllowFiltering="true" AutoPostBackOnFilter="true" ItemStyle-Width="40px">
                    </telerik:GridBoundColumn>             
                    <telerik:GridBoundColumn DataField="MAT_CODE" FilterControlAltText="Filter MAT_CODE column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE" UniqueName="MAT_CODE" AllowFiltering="true" AutoPostBackOnFilter="true" ItemStyle-Width="40px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" AllowFiltering="true" AutoPostBackOnFilter="true" ItemStyle-Width="10px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AllowFiltering="true" AutoPostBackOnFilter="true" ItemStyle-Width="350px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RELEASE_QTY" DataType="System.Decimal" FilterControlAltText="Filter RELEASE_QTY column" HeaderText="RELEASE QTY" SortExpression="RELEASE_QTY" UniqueName="RELEASE_QTY"  AllowFiltering="false"  ItemStyle-Width="60px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" HeaderText="INSP QTY" SortExpression="INSP_QTY" UniqueName="INSP_QTY" AllowFiltering="false"  ItemStyle-Width="30px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRR_QTY" DataType="System.Decimal" FilterControlAltText="Filter MRR_QTY column" HeaderText="MRR QTY" SortExpression="MRR_QTY" UniqueName="MRR_QTY" AllowFiltering="false"  ItemStyle-Width="30px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RFI_QTY" DataType="System.Decimal" FilterControlAltText="Filter RFI_QTY column" HeaderText="RFI QTY" SortExpression="RFI_QTY" UniqueName="RFI_QTY" AllowFiltering="false"  ItemStyle-Width="30px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter MRIR_RCV_QTY column" HeaderText="MRIR RCV QTY" SortExpression="MRIR_RCV_QTY" UniqueName="MRIR_RCV_QTY" AllowFiltering="false"  ItemStyle-Width="50px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_ACT_QTY" DataType="System.Decimal" FilterControlAltText="Filter MRIR_ACT_QTY column" HeaderText="MRIR ACT QTY" SortExpression="MRIR_ACT_QTY" UniqueName="MRIR_ACT_QTY" AllowFiltering="false"  ItemStyle-Width="60px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false"/>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_ATableAdapters.VIEW_TOTAL_MAT_REPTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

