<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="VendorsNew.aspx.cs" Inherits="Vendors_VendorsNew" %>
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
    <div>
        <table>
             <tr>
                <td class="Heading">Vendor Code*</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtVendorCode" Width="125px" required></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Vendor Name*</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtVendorName" Width="250px" required></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Approved Vendor*</td>
                <td>
                    <asp:RadioButtonList ID="radApproved" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="Yes" Value="Y" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="No" Value="N"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
             <tr>
                <td class="Heading" colspan="2" style="font-weight:bold">Vendor Address</td>                
            </tr>
             <tr>
                <td class="Heading">Line 1*</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtAddLine1" Width="250px" required></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Line 2</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtAddLine2" Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Line 3</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtAddLine3" Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Area</td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtAddArea" Width="250px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Country*</td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtCountry" runat="server" Width="250px" EmptyMessage="Start Typing Country.. " DataSourceID="sqlCountrySource" DataTextField="COUNTRY_NAME" 
                        DataValueField="COUNTRY_ID" DropDownHeight="200px" InputType="Text">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
              <tr>
                <td class="Heading" colspan="2" style="font-weight:bold">Contact Details*</td>                
            </tr>
            <tr>                
                <td class="Heading" colspan="2">
                    <telerik:RadTextBox ID="txtPhone" runat="server" Width="180px" EmptyMessage="Phone Number" required></telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtFax" runat="server" Width="180px" EmptyMessage="FAX Number" required></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Icon-PrimaryIconUrl="~/Images/New-Icons/document-save.png" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="color:tomato">
                    (Note:- Fields Marked with (*) are mandatory)
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlCountrySource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT COUNTRY_ID, COUNTRY_NAME 
FROM COUNTRY_LIST"></asp:SqlDataSource>
</asp:Content>

