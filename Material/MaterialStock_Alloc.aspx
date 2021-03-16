<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Alloc.aspx.cs" Inherits="Material_MaterialStock_Alloc" Title="Material - Allocation" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke; padding: 3px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <asp:GridView ID="jcGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="itemsDataSource" PageSize="20" Width="100%">
            <Columns>
                <asp:BoundField DataField="MATRIX_PRTY" HeaderText="MATRIX_PRTY" SortExpression="MATRIX_PRTY" />
                <asp:BoundField DataField="CRD_DATE" HeaderText="CRD" SortExpression="CRD_DATE" HtmlEncode="false" DataFormatString="{0:dd-MMM-yy}" />
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                <asp:BoundField DataField="WO_NAME" HeaderText="Spool Jobcard" SortExpression="WO_NAME" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                <asp:BoundField DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" />
                <asp:BoundField DataField="AVAILABLE" HeaderText="Avl. (Inv)" SortExpression="AVAILABLE" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                <asp:BoundField DataField="NET_QTY" HeaderText="Net Qty" SortExpression="NET_QTY" />
                <asp:BoundField DataField="ALLOC_BAL_QTY" HeaderText="Inventory Qty" SortExpression="ALLOC_BAL_QTY" />
                <asp:BoundField DataField="PO_NO" HeaderText="PO No" SortExpression="PO_NO" />
                <asp:BoundField DataField="ETA_DATE" HeaderText="ETA Date" SortExpression="ETA_DATE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ISO_TITLE1, SPOOL, WO_NAME, SML_DATE, PT_NO, ITEM_NAM, MAT_CODE1, SIZE_DESC, WALL_THK, SF_FLG, AVAILABLE, PAINT_AVL, NET_QTY, PO_NO, ETA_DATE, UOM, ALLOC_BAL_QTY, ALLOC_SEQ_NO, CRD_DATE, MATRIX_PRTY FROM VIEW_BOM_ALLOC WHERE (MAT_ID = :MAT_ID) ORDER BY ALLOC_SEQ_NO, MATRIX_PRTY, CRD_DATE, ISO_TITLE1, SPOOL">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>