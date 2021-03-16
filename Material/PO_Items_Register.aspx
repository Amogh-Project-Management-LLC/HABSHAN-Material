<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="PO_Items_Register.aspx.cs" Inherits="Material_PO_Items_Register" Title="PO Items - New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label6" runat="server" Text="Control No:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCtrlNo" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label1" runat="server" Text="PO Item:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPOItem" runat="server" Width="76px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="poItemValidator" runat="server" ControlToValidate="txtPOItem"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">PA Item:
                </td>
                <td>
                    <asp:TextBox ID="txtPA_Item" runat="server" Width="76px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PA_ItemValidator" runat="server" ControlToValidate="txtPA_Item"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label2" runat="server" Text="Material Code:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtMatCode" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" Width="12px"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label3" runat="server" Text="PO Quantity:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPOQty" runat="server" Width="76px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtPOQty"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label4" runat="server" Text="Delivery Date:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDeliveryDate" runat="server" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="ddValidator" runat="server" ControlToValidate="txtDeliveryDate"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: Gainsboro">
                    <asp:Label ID="Label5" runat="server" Text="Remarks:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="450px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke">
        <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            Text="Submit" Width="80px" OnClick="btnSubmit_Click" />
    </div>
</asp:Content>