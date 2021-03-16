<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_BOM.aspx.cs" Inherits="HeatNo_HeatNo_BOM" Title="Heat No - BOM" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
        <asp:GridView ID="bomGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="bomDataSource" Width="100%" AllowPaging="True" PageSize="18" OnDataBound="bomGridView_DataBound">
            <Columns>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool No" SortExpression="SPOOL" />
                <asp:BoundField DataField="PT_NO" HeaderText="Part No" SortExpression="PT_NO" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                <asp:BoundField DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                <asp:BoundField DataField="SF_FLG" HeaderText="SF_FLG" SortExpression="SF_FLG" />
                <asp:BoundField DataField="HEAT_NO" HeaderText="Heat No" SortExpression="HEAT_NO" />
                <asp:BoundField DataField="AVAILABLE" HeaderText="Available" SortExpression="AVAILABLE" />
                <asp:BoundField DataField="NET_QTY" HeaderText="Net Qty" SortExpression="NET_QTY"
                    DataFormatString="{0:f}" HtmlEncode="False" />
                <asp:BoundField DataField="PIPE_EP1" HeaderText="Pipe EP1" SortExpression="PIPE_EP1" />
                <asp:BoundField DataField="PIPE_EP2" HeaderText="Pipe EP2" SortExpression="PIPE_EP2" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_BOM_TOTAL WHERE PROJ_ID = :PROJECT_ID AND HEAT_NO = :HEAT_NO ORDER BY ISO_TITLE1, PT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>