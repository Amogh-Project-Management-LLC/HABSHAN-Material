<%@ Page Title="" Language="C#" MasterPageFile="~/PopUpMasterPage.master" AutoEventWireup="true" CodeFile="PODetailsAdd.aspx.cs" Inherits="Procurement_PODetailsAdd" %>
<%@ MasterType VirtualPath="~/PopUpMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
           width:120px;
           background-color: whitesmoke;
           padding-left:5px;
        }
    </style>
    <div style="background-color: whitesmoke">       
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px"></telerik:RadButton>
    </div>
    <div>
        <table>
              <tr>
                <td class="Heading">
                    PO Item
                </td>
                <td>
                    <telerik:RadTextBox ID="txtPOItem" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    MR Item
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlMRItem" runat="server"></telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Mat Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatCode" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
              <tr>
                <td class="Heading">
                    Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

