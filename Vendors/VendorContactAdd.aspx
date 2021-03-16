<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="VendorContactAdd.aspx.cs" Inherits="Vendors_VendorContactAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style type="text/css">
        .Heading {
            background-color:whitesmoke;
            width:120px;
            padding-left:5px;
            height:20px;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">Title</td>
            <td>
                <asp:RadioButtonList ID="radTitle" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Mr." Value="Mr" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Ms." Value="Ms"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="Heading">Name</td>
            <td>
                <telerik:RadTextBox ID="txtFirstName" runat="server" EmptyMessage="First Name" Width="200px" required></telerik:RadTextBox>
                <telerik:RadTextBox ID="txtLastName" runat="server" EmptyMessage="Last Name" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Email ID</td>
            <td>
                <telerik:RadTextBox ID="txtEmailID" runat="server" EmptyMessage="Email ID" Width="400px" InputType="Email"></telerik:RadTextBox>               
            </td>
        </tr>
        <tr>
            <td class="Heading">Contact No</td>
            <td>
                <telerik:RadTextBox ID="txtLandline" runat="server" EmptyMessage="Landline Number.." Width="200px" required></telerik:RadTextBox>
                <telerik:RadTextBox ID="txtMobile" runat="server" EmptyMessage="Mobile Number.." Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Fax Number</td>
            <td>
                <telerik:RadTextBox ID="txtFax" runat="server" EmptyMessage="Fax Number.." Width="200px"></telerik:RadTextBox>              
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                
                <telerik:RadButton runat="server" id="btnSave" Text="Save" Width="80px" OnClick="btnSave_Click">
                    <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
                </telerik:RadButton>
            </td>
        </tr>
    </table>
</asp:Content>

