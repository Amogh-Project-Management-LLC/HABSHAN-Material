<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_BOM_QTY.aspx.cs" Inherits="MaterialStock_BOM_QTY" Title="Material - BOM" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <asp:GridView ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="itemsDataSource" PageSize="20" Width="100%">
            <Columns>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="JC_NO" HeaderText="JC Number" SortExpression="JC_NO" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                <asp:BoundField DataField="MAT_AVL" HeaderText="Spl Avl." SortExpression="MAT_AVL" />
                <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" />
                <asp:BoundField DataField="AVAILABLE" HeaderText="Avl. (Inv)" SortExpression="AVAILABLE" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                <asp:BoundField DataField="NET_QTY" HeaderText="Net Qty" SortExpression="NET_QTY" />
                <asp:BoundField DataField="ETA_DATE" HeaderText="ETA Date" SortExpression="ETA_DATE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JC_NO, SUB_CON, ISO_TITLE1, SPOOL, MAT_AVL, MAT_TYPE, MAT_CLASS, SML_DATE, PT_NO, ITEM_NAM, MAT_CODE1, SIZE_DESC, WALL_THK, MAT_DESCR, SF_FLG, HEAT_NO, AVAILABLE, PAINT_AVL, NET_QTY, PIPE_EP1, PIPE_EP2, PO_NO, ETA_DATE, UOM FROM VIEW_BOM_TOTAL WHERE (MAT_ID = :MAT_ID) ORDER BY ISO_TITLE1, SPOOL, MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>