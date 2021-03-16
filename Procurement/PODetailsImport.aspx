<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PODetailsImport.aspx.cs" Inherits="Procurement_PODetailsImport" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/new-icons/left-arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="90px" OnClick="btnSave_Click">
            <Icon PrimaryIconUrl="../Images/new-icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 5px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlGridSource">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource">
                <Columns>
                    <telerik:GridTemplateColumn ItemStyle-Width="20px" UniqueName="cbColumn">
                        <ItemTemplate>
                            <telerik:RadCheckBox ID="itemCheck" runat="server" Checked="True"></telerik:RadCheckBox>
                        </ItemTemplate>
                        <HeaderTemplate>
                            <telerik:RadCheckBox ID="itemHeaderCheck" runat="server" Checked="True" AutoPostBack="true"
                                OnCheckedChanged="itemHeaderCheck_CheckedChanged">
                            </telerik:RadCheckBox>
                        </HeaderTemplate>

                        <ItemStyle Width="20px"></ItemStyle>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MR_NO" FilterControlAltText="Filter MR_NO column" HeaderText="MR NO" SortExpression="MR_NO" UniqueName="MR_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" DataType="System.Decimal" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM NO" SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TAG_NO" FilterControlAltText="Filter TAG_NO column" HeaderText="TAG NO" SortExpression="TAG_NO" UniqueName="TAG_NO">
                    </telerik:GridBoundColumn>
                   
                    <telerik:GridBoundColumn DataField="MR_QTY" DataType="System.Decimal" FilterControlAltText="Filter MR_QTY column" HeaderText="MR QTY" SortExpression="MR_QTY" UniqueName="MR_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BAL_TO_ORD" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_ORD column" HeaderText="BALANCE TO ORD" SortExpression="BAL_TO_ORD" UniqueName="BAL_TO_ORD">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_TO_ORDLabel" runat="server" Text='<%# Eval("BAL_TO_ORD") %>' Width="80px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_MR_PO_BAL
WHERE MR_ID = :MR_ID AND BAL_TO_ORD>0">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenMRID" DefaultValue="-1" Name="MR_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenMRID" runat="server" />
</asp:Content>

