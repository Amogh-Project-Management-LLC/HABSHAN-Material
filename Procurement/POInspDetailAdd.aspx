<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POInspDetailAdd.aspx.cs" Inherits="Procurement_POInspDetailAdd" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Save" Width="100px" OnClick="btnAdd_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsSource">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsSource">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol" ItemStyle-Width="20px">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>

                        <ItemStyle Width="20px"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO_ITEM_NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO_QTY" SortExpression="PO_QTY" UniqueName="PO_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" HeaderText="INSP QTY" SortExpression="INSP_QTY" UniqueName="INSP_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="REMAIN INSP QTY" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_QTYTextBox" runat="server" Text='<%# Bind("BAL_QTY") %>' Width="80px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_PO_INSP_BAL
WHERE po_id IN (SELECT po_id FROM PIP_PO_INSP_REQUEST WHERE RFI_ID = :RFI_ID)
AND BAL_QTY &gt; 0">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RFI_ID" QueryStringField="RFI_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

