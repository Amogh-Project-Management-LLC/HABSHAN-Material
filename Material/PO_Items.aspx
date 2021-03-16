<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PO_Items.aspx.cs" Inherits="Material_PurchaseOrderItems" Title="PO Items" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnPOList_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="80" CausesValidation="false" Enabled="False"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" CausesValidation="false" Enabled="False" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80" Visible="false" Enabled="False" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            PageSize="18" Width="100%" OnDataBound="itemsGridView_DataBound" SkinID="GridViewSkin"
            DataKeyNames="PO_ITEM_ID" DataSourceID="PO_DetailsDataSource">
            <EmptyDataTemplate>
                No Data!
            </EmptyDataTemplate>
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    ShowEditButton="false" UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="30px" />
                </asp:CommandField>
                <asp:BoundField DataField="PO_ITEM" HeaderText="PO Item" SortExpression="PO_ITEM" />
                <asp:BoundField DataField="PA_ITEM" HeaderText="PA Item" SortExpression="PA_ITEM" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1" />
                <asp:BoundField DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                <asp:BoundField DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                <asp:BoundField DataField="ITEM_NAM" HeaderText="Item Name" SortExpression="ITEM_NAM" />
                <asp:BoundField DataField="PO_QTY" HeaderText="PO Qty" SortExpression="PO_QTY" />
                <asp:BoundField DataField="PART_QTY" HeaderText="Part Qty" SortExpression="PART_QTY" />
                <asp:BoundField DataField="QTY_SHIPPED" HeaderText="Qty Shipped" SortExpression="QTY_SHIPPED" />
                <asp:BoundField DataField="ETA" HeaderText="ETA" SortExpression="ETA" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="ETA_FA" HeaderText="ETA FA" SortExpression="ETA_FA" />
                <asp:BoundField DataField="AT_SITE" HeaderText="At Site" SortExpression="AT_SITE" DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                <asp:BoundField DataField="AT_SITE_FA" HeaderText="At Site FA" SortExpression="AT_SITE_FA" />
                <asp:BoundField DataField="SHIPMENT_NO" HeaderText="Ship No" SortExpression="SHIPMENT_NO" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="PO_DetailsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsPO_ShipmentTableAdapters.PIP_PO_DETAILTableAdapter"
        DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PO_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>