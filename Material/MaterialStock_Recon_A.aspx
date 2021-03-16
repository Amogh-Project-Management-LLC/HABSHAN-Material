<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Recon_A.aspx.cs" Inherits="Material_MaterialStock_Recon_A" Title="Material Reconciliation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro; padding: 2px;">
        <table>
            <tr>
                <td>
                     <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtAutoMatCode" runat="server" DataSourceID="sqlMaterialCode" DataTextField="MAT_CODE1" 
                        DataValueField="MAT_ID" DropDownHeight="400px" DropDownWidth="200px" EmptyMessage="Search Item Code...." InputType="Text" 
                        MinFilterLength="2" Width="200px" OnTextChanged="txtAutoMatCode_TextChanged" AutoPostBack="true"
                        OnEntryAdded="txtAutoMatCode_EntryAdded">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
                <td>
                    <telerik:RadButton ID="RadButton1" runat="server" Text="Search.." Width="80px"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top: 3px;">
        <telerik:RadGrid ID="RadGrid2" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource2" GridLines="None">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
                <Columns>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE2" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        
        <div style="margin-top: 13px; margin-left:3px; font-weight:bold; text-decoration:underline; color:gray">
            Stock Information
        </div>
        <div style="margin-top:3px;">
            <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1">
                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
                    <Columns>
                        <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUB_CON_NAME" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="RCVD_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCVD_QTY column" HeaderText="RCVD_QTY" SortExpression="RCVD_QTY" UniqueName="RCVD_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ACPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACPT_QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SD_QTY" DataType="System.Decimal" FilterControlAltText="Filter SD_QTY column" HeaderText="SD_QTY" SortExpression="SD_QTY" UniqueName="SD_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SD_CLR_QTY" DataType="System.Decimal" FilterControlAltText="Filter SD_CLR_QTY column" HeaderText="SD_CLR_QTY" SortExpression="SD_CLR_QTY" UniqueName="SD_CLR_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TRANS_RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter TRANS_RCV_QTY column" HeaderText="TRANS_RCV_QTY" SortExpression="TRANS_RCV_QTY" UniqueName="TRANS_RCV_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ADD_ISSUE" DataType="System.Decimal" FilterControlAltText="Filter ADD_ISSUE column" HeaderText="MAT MIV QTY" SortExpression="ADD_ISSUE" UniqueName="ADD_ISSUE">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TOTAL_JC_QTY" DataType="System.Decimal" FilterControlAltText="Filter TOTAL_JC_QTY column" HeaderText="TOTAL JC QTY" SortExpression="TOTAL_JC_QTY" UniqueName="TOTAL_JC_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="TRANSF_OUT_QTY" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_OUT_QTY column" HeaderText="TRANSFER QTY" SortExpression="TRANSF_OUT_QTY" UniqueName="TRANSF_OUT_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="REMAIN_QTY" DataType="System.Decimal" FilterControlAltText="Filter REMAIN_QTY column" HeaderText="REMAIN_QTY" SortExpression="REMAIN_QTY" UniqueName="REMAIN_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="QRNTINE_QTY" DataType="System.Decimal" FilterControlAltText="Filter QRNTINE_QTY column" HeaderText="QRNTINE_QTY" SortExpression="QRNTINE_QTY" UniqueName="QRNTINE_QTY">
                        </telerik:GridBoundColumn>
 <telerik:GridBoundColumn DataField="RETURN_QTY" DataType="System.Decimal" FilterControlAltText="Filter RETURN_QTYcolumn" HeaderText="RETURN QTY" SortExpression="RETURN_QTY" UniqueName="RETURN_QTY">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BAL_QTY" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_NAME, UOM, RCVD_QTY, ACPT_QTY, SD_QTY, SD_CLR_QTY, TRANS_RCV_QTY, ADD_ISSUE,TOTAL_JC_QTY,TRANSF_OUT_QTY, REMAIN_QTY,  QRNTINE_QTY, RETURN_QTY,BAL_QTY
FROM VIEW_ITEM_REP_A
WHERE MAT_ID = :MAT_ID
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_STOCK
WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMaterialCode" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK WHERE PROJ_ID = :PROJ_ID ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
