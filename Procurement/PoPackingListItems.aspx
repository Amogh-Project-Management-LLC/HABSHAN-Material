<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PoPackingListItems.aspx.cs" Inherits="PoPackingListItems" Title="Packing List" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">PO Item No</td>
                <td>
                    <asp:TextBox ID="txtPoItemNo" runat="server"
                        Width="50px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="poItemValidator" runat="server" ControlToValidate="txtPoItemNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Material Code
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server"
                        Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Package Style
                </td>
                <td>
                    <asp:DropDownList ID="ddPackageStyle" runat="server" Width="200px" DataSourceID="PkgStyleSqlDataSource" DataTextField="PKG_NO" DataValueField="PKG_STYLE_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Qty</td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Package Qty</td>
                <td>
                    <asp:TextBox ID="txtPkgQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="pkgQtyValidator" runat="server" ControlToValidate="txtPkgQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Unit Weight (Net)</td>
                <td>
                    <asp:TextBox ID="txtUnitWeightNet" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="netUnitWeightValidator" runat="server" ControlToValidate="txtUnitWeightNet"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Unit Weight (Gross)</td>
                <td>
                    <asp:TextBox ID="txtUnitWeightGross" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="grossUnitWeightValidator" runat="server" ControlToValidate="txtUnitWeightGross"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="350px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="PKL_ITEM_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            OnDataBound="itemsGridView_DataBound" PageSize="18" Width="100%">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:TemplateField HeaderText="PO Item" SortExpression="PO_ITEM_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox12" runat="server" Text='<%# Bind("PO_ITEM_NO") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label12" runat="server" Text='<%# Bind("PO_ITEM_NO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PKG_NO" HeaderText="Pkg No" SortExpression="PKG_NO" ReadOnly="True" />
                <asp:BoundField DataField="MAT_CODE1" HeaderText="Item Code" SortExpression="MAT_CODE1" ReadOnly="true" />
                <asp:BoundField DataField="UOM" HeaderText="UOM" SortExpression="UOM" ReadOnly="true" />
                <asp:TemplateField HeaderText="QTY" SortExpression="QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Pkg Qty" SortExpression="PKG_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PKG_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PKG_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit WT (Net)" SortExpression="UNIT_NET_WEIGHT">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("UNIT_NET_WEIGHT") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("UNIT_NET_WEIGHT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit WT (Grs.)" SortExpression="UNIT_GROSS_WEIGHT">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("UNIT_GROSS_WEIGHT") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("UNIT_GROSS_WEIGHT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Rej Qty" SortExpression="REJECTED_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("REJECTED_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("REJECTED_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NV Qty" SortExpression="NV_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("NV_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("NV_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Dmg Qty" SortExpression="DAMAGE_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("DAMAGE_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("DAMAGE_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Off-Spec Qty" SortExpression="OFFSPEC_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("OFFSPEC_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("OFFSPEC_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Short Qty" SortExpression="SHORTAGE_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("SHORTAGE_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("SHORTAGE_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Overage Qty" SortExpression="OVERAGE_QTY">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox10" runat="server" Text='<%# Bind("OVERAGE_QTY") %>' Width="50px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("OVERAGE_QTY") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remarks" SortExpression="REMARKS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox11" runat="server" Text='<%# Bind("REMARKS") %>' Width="100px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label11" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: gainsboro;">
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

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="PO_PackingListTableAdapters.VIEW_MAT_PK_LIST_DETAILTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PKL_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PKL_ID" QueryStringField="PKL_ID"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_ITEM_NO" Type="String" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="PKG_QTY" Type="Decimal" />
            <asp:Parameter Name="UNIT_NET_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="UNIT_GROSS_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="REJECTED_QTY" Type="Decimal" />
            <asp:Parameter Name="NV_QTY" Type="Decimal" />
            <asp:Parameter Name="DAMAGE_QTY" Type="Decimal" />
            <asp:Parameter Name="OFFSPEC_QTY" Type="Decimal" />
            <asp:Parameter Name="SHORTAGE_QTY" Type="Decimal" />
            <asp:Parameter Name="OVERAGE_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_PKL_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="PkgStyleSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PKG_STYLE_ID, PKG_NO FROM MAT_PK_LIST_STYLE WHERE (PKL_ID = :PKL_ID) ORDER BY PKG_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PKL_ID" QueryStringField="PKL_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>