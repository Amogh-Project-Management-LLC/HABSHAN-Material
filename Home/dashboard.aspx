<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dashboard.aspx.cs" Inherits="Home_dashboard" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table>
        <tr>
            <td style="vertical-align: top">
                <div style="height:30px; padding-top:10px; padding-left:5px; background-color: whitesmoke; font-size:16px; font-weight:bold; color:dimgray; font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif">
                    Overall Material Summary:
                </div>
                <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="sqlPipeSummary">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlPipeSummary">
                        <Columns>
                            <telerik:GridBoundColumn DataField="ITEM_GROUP" FilterControlAltText="Filter ITEM_GROUP column" HeaderText="ITEM_GROUP" SortExpression="ITEM_GROUP" UniqueName="ITEM_GROUP">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UoM" SortExpression="UOM" UniqueName="UOM">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ORD_QTY" DataType="System.Decimal" FilterControlAltText="Filter ORD_QTY column" HeaderText="PO QTY" SortExpression="ORD_QTY" UniqueName="ORD_QTY">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DELIVERED" DataType="System.Decimal" FilterControlAltText="Filter DELIVERED column" HeaderText="DELIVERED" SortExpression="DELIVERED" UniqueName="DELIVERED">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BAL_TO_RCV" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_RCV column" HeaderText="BAL_TO_RCV" SortExpression="BAL_TO_RCV" UniqueName="BAL_TO_RCV">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DELV_PRCNT" DataType="System.Decimal" FilterControlAltText="Filter DELV_PRCNT column" HeaderText="DELV_PRCNT" SortExpression="DELV_PRCNT" UniqueName="DELV_PRCNT">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
             <td>
                <telerik:RadHtmlChart ID="RadHtmlChart1" runat="server" DataSourceID="sqlPipeSummary" Width="600px" Height="230px">
                    <Legend>
                        <Appearance Visible="True"></Appearance>
                    </Legend>
                    <PlotArea>
                        <XAxis Visible="True" DataLabelsField="ITEM_GROUP">
                            <LabelsAppearance RotationAngle="0">
                            </LabelsAppearance>
                        </XAxis>
                        <Series>
                            <telerik:BarSeries DataFieldY="DELIVERED" Name="Delivered Qty" Stacked="True" StackType="Stack100">
                                <LabelsAppearance Position="Center">
                                </LabelsAppearance>
                            </telerik:BarSeries>
                            <telerik:BarSeries DataFieldY="BAL_TO_RCV" Name="Balance to deliver">
                            </telerik:BarSeries>
                        </Series>
                    </PlotArea>
                </telerik:RadHtmlChart>
            </td>            
        </tr>
    </table>
    <div>

    </div>

    <asp:SqlDataSource ID="sqlPipeSummary" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_PO_DELIV_REP
        WHERE ITEM_gROUP is not null"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_DASHBOARD_PIE
        WHERE ITEM_gROUP = 'PIPE'"></asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_DASHBOARD_PIE
        WHERE ITEM_gROUP = 'FITTING'"></asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_DASHBOARD_PIE
        WHERE ITEM_gROUP = 'FLANGE'"></asp:SqlDataSource>
      <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_DASHBOARD_PIE
        WHERE ITEM_gROUP = 'VALVE'"></asp:SqlDataSource>
</asp:Content>

