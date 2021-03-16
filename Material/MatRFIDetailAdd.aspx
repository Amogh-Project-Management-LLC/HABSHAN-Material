<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatRFIDetailAdd.aspx.cs" Inherits="Material_MatTransRcvAdd" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" AllowFilteringByColumn="true" DataSourceID="sqlGridSource" AllowMultiRowSelection="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" ></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                    </telerik:GridClientSelectColumn>   
                     <telerik:GridBoundColumn DataField="RCV_ITEM_ID" FilterControlAltText="Filter RCV_ITEM_ID column" HeaderText="RCV ITEM ID" SortExpression="RCV_ITEM_ID" UniqueName="RCV_ITEM_ID" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRR NO" SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM NUM" SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true" FilterControlWidth="40px" >
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV_QTY" SortExpression="RCV_QTY" UniqueName="RCV_QTY" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="INSP_PIECES" DataType="System.Decimal" FilterControlAltText="Filter INSP_PIECES column" HeaderText="INSP_PIECES" SortExpression="INSP_PIECES" UniqueName="INSP_PIECES" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BAL_TO_INSP_PIECES" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_INSP_PIECES column" HeaderText="BAL_TO_INSP_PIECES" SortExpression="BAL_TO_INSP_PIECES" UniqueName="BAL_TO_INSP_PIECES" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="BAL_TO_INSP_PIECESTextBox" runat="server" Text='<%# Bind("BAL_TO_INSP_PIECES") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="BAL_TO_INSP_PIECESLabel" runat="server" Text='<%# Eval("BAL_TO_INSP_PIECES") %>' Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" HeaderText="INSP_QTY" SortExpression="INSP_QTY" UniqueName="INSP_QTY" AllowFiltering="false">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="BAL_TO_INSP" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_INSP column" HeaderText="BAL_TO_INSP" SortExpression="BAL_TO_INSP" UniqueName="BAL_TO_INSP" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="BAL_TO_INSPTextBox" runat="server" Text='<%# Bind("BAL_TO_INSP") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="BAL_TO_INSPLabel" runat="server" Text='<%# Eval("BAL_TO_INSP") %>' Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_MAT_BAL_TO_RFI
WHERE MAT_RCV_ID IN (SELECT MRR_ID FROM VIEW_MAT_INSP_REQUEST WHERE RFI_ID = :RFI_ID)
ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RFI_ID" QueryStringField="RFI_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

