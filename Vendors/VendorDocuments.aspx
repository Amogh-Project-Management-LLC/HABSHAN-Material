<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="VendorDocuments.aspx.cs" Inherits="Vendors_VendorDocuments" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="background-color:whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="90px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png"/>
        </telerik:RadButton>
    </div>
</asp:Content>

