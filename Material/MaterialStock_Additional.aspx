<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Additional.aspx.cs" Inherits="Material_MaterialStock_BOM"
    Title="Additional Mat" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <asp:GridView ID="bomGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="addDataSource" PageSize="15" Width="100%">
            <Columns>
                <asp:BoundField DataField="ISSUE_NO" HeaderText="Issue No" SortExpression="ISSUE_NO" />
                <asp:BoundField DataField="ISSUE_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Issue Date"
                    HtmlEncode="False" SortExpression="ISSUE_DATE" />
                <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" />
                <asp:BoundField DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" />
                <asp:BoundField DataField="CATEGORY" HeaderText="Category" SortExpression="CATEGORY" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                <asp:BoundField DataField="HEAT_NO" HeaderText="Heat No" SortExpression="HEAT_NO" />
                <asp:BoundField DataField="ISSUE_QTY" HeaderText="Issued Qty" SortExpression="ISSUE_QTY" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:SqlDataSource ID="addDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_TOTAL_ADD_ISSUE  &#13;&#10;WHERE (PROJECT_ID = :PROJECT_ID) &#13;&#10;AND (MAT_ID = :MAT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>