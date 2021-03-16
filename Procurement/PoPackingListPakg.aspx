<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PoPackingListPakg.aspx.cs" Inherits="PoPackingListPakg" Title="Packing List" %>

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
                <td style="width: 120px; background-color: whitesmoke;">Package Style</td>
                <td>
                    <asp:TextBox ID="txtPackageStyle" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="packageStyleValidator" runat="server" ControlToValidate="txtPackageStyle"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Package No
                </td>
                <td>
                    <asp:TextBox ID="txtPackageNo" runat="server" Width="150px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="packageNoValidator" runat="server" ControlToValidate="txtPackageNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Length (CM)</td>
                <td>
                    <asp:TextBox ID="txtLength" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="lengthValidator" runat="server" ControlToValidate="txtLength"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Width (CM)</td>
                <td>
                    <asp:TextBox ID="txtWidth" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="WidthValidator" runat="server" ControlToValidate="txtWidth"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Height (CM)</td>
                <td>
                    <asp:TextBox ID="txtHeight" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="heightValidator" runat="server" ControlToValidate="txtHeight"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Volume SQM</td>
                <td>
                    <asp:TextBox ID="txtVolume" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="volumeValidator" runat="server" ControlToValidate="txtVolume"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="PKG_STYLE_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            OnDataBound="itemsGridView_DataBound" PageSize="18" Width="100%">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="PKG_STYLE" HeaderText="Package Style" SortExpression="PKG_STYLE" />
                <asp:BoundField DataField="PKG_NO" HeaderText="Package No" SortExpression="PKG_NO" />
                <asp:BoundField DataField="DIM_LENGTH_CM" HeaderText="Length (CM)" SortExpression="DIM_LENGTH_CM" />
                <asp:BoundField DataField="DIM_WIDTH_CM" HeaderText="Width (CM)" SortExpression="DIM_WIDTH_CM" />
                <asp:BoundField DataField="DIM_HEIGHT_CM" HeaderText="Height (CM)" SortExpression="DIM_HEIGHT_CM" />
                <asp:BoundField DataField="VOLUME_SQM" HeaderText="Volume SQM" SortExpression="VOLUME_SQM" />
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
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="PO_PackingListTableAdapters.VIEW_MAT_PK_LIST_STYLETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_PKG_STYLE_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PKL_ID" QueryStringField="PKL_ID"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PKG_STYLE" Type="String" />
            <asp:Parameter Name="DIM_LENGTH_CM" Type="Decimal" />
            <asp:Parameter Name="DIM_WIDTH_CM" Type="Decimal" />
            <asp:Parameter Name="DIM_HEIGHT_CM" Type="Decimal" />
            <asp:Parameter Name="VOLUME_SQM" Type="Decimal" />
            <asp:Parameter Name="PKG_NO" Type="String" />
            <asp:Parameter Name="Original_PKG_STYLE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>