<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MTNReceiveDetailImport.aspx.cs" Inherits="Material_MTNReceiveDetailImport" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px"></telerik:RadButton>

    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sqlItemSource" ClientSettings-Scrolling-AllowScroll="true" Height="550px">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlItemSource">
                <Columns>
                    <telerik:GridTemplateColumn>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="true"/>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_NO" FilterControlAltText="Filter TRANSF_NO column" HeaderText="TRANSF_NO" SortExpression="TRANSF_NO" UniqueName="TRANSF_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_QTY" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_QTY column" HeaderText="TRANSFER QTY" SortExpression="TRANSF_QTY" UniqueName="TRANSF_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="PREVIOUS RECEIVE" SortExpression="RCV_QTY" UniqueName="RCV_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BALANCE" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="RECEIVE">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtRCVQty" runat="server" Text='<%# Bind("BAL_QTY") %>' Width="100px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="EXCESS">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtExcess" runat="server" Text="0" Width="100px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SHORTAGE">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtShortage" runat="server" Text="0" Width="100px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="DAMAGE">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtDamage" runat="server" Text="0" Width="100px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="REMARKS">
                        <ItemTemplate>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" EmptyMessage="Remarks...." Width="200px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_MAT_TRANSFER_RCV_BAL
WHERE TRANSF_ID = (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV WHERE RCV_ID = :RCV_ID)
AND BAL_QTY &gt; 0">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

