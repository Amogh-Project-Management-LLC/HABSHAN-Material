<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_ESD.aspx.cs" Inherits="HeatNo_HeatNo_ESD" Title="Heat No - ESD" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="matsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="MatExcepDataSource" Width="100%" AllowPaging="True" PageSize="18"
            OnDataBound="matsGridView_DataBound">
            <Columns>
                <asp:BoundField DataField="REP_NO" HeaderText="Report No" SortExpression="REP_NO" />
                <asp:BoundField DataField="REP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Report Date"
                    HtmlEncode="False" SortExpression="REP_DATE" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                <asp:BoundField DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                <asp:BoundField DataField="HEAT_NO" HeaderText="Heat No" SortExpression="HEAT_NO" />
                <asp:BoundField DataField="EXCP_DESCR" HeaderText="Exception" SortExpression="EXCP_DESCR" />
                <asp:BoundField DataField="EXCP_QTY" HeaderText="Excp Qty" SortExpression="EXCP_QTY" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="MatExcepDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_MAT_EXCEPTION
WHERE PROJ_ID = :PROJECT_ID AND HEAT_NO = :HEAT_NO
ORDER BY REP_DATE, MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>